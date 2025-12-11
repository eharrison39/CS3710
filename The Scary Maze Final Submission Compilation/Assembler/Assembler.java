import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.nio.file.Files;
import java.nio.file.Path;
import java.io.IOException;

public class Assembler {
    public static void main(String[] args) {
        System.out.println("Assembler is running...");

        // Initialize Variables
        List<Line> lines = new ArrayList<Line>();
        List<String> hexInstructions = new ArrayList<String>();

        // Read Input File
        Scanner scanner;
        try {
            File file = new File("theActualCode.asm");
            scanner = new Scanner(file);
        } catch (FileNotFoundException e) {
            System.out.println("Sorry boss!  File not found!");
            return;
        }
        int lineNumber = 0;

        while (scanner.hasNextLine()) {
            lineNumber++;
            lines.add(new Line(scanner.nextLine(), lineNumber));
        }
        scanner.close();
        
        // Put into tokens and verify syntax
        for (Line line : lines) {
            line.addTokens();
        }

        // Translate to hex and verify each instruction is valid along the way
        for (Line line : lines) {
            String hexInstruction = line.verifySyntaxAndGenerateHex();
            if (hexInstruction != null) {
                hexInstructions.add(hexInstruction);
            }
        }

        // Generate output file
        try {
            Files.write(Path.of("output.hex"), hexInstructions);
        } catch (IOException e) {
            System.out.println("Error writing to output file: " + e.getMessage());
        }

        System.out.println("End Assembler!");
    }

    public static String regToHex(String reg) {
        int regNum = Integer.parseInt(reg.substring(1));
        return Integer.toHexString(regNum);
    }

    public static String signedNumToHex(String imm, int lineNumber, String lineContents, boolean isImmediate) {
        int immNum = Integer.parseInt(imm);
        if(immNum > 127){
            String numType = isImmediate ? "Immediate" : "Displacement";
            System.out.println(numType + " value cannot be greater than 127.  This is on line " + lineNumber + ": " + lineContents);
            System.exit(0);
        } else if(immNum < -128){
            String numType = isImmediate ? "Immediate" : "Displacement";
            System.out.println(numType + " value cannot be less than -128.  This is on line " + lineNumber + ": " + lineContents);
            System.exit(0);
        }

        String hexNum = Integer.toHexString(immNum & 0xFF);
        if(hexNum.length() == 1)
            hexNum = "0" + hexNum;
        return hexNum;
    }

    public static String unsignedNumToHex(String imm, int lineNumber, String lineContents) {
        int immNum = Integer.parseInt(imm);
        if(immNum < 0 || immNum > 255){
            System.out.println("Immediate value must be between 0 and 255.  This is on line " + lineNumber + ": " + lineContents);
            System.exit(0);
        }

        String hexNum = Integer.toHexString(immNum);
        if(hexNum.length() == 1)
            hexNum = "0" + hexNum;
        return hexNum;
    }

    public static class Line {
        public String contents;
        public int number;  // Line number
        public List<Token> tokens;

        public Line(String contents, int number) {
            this.contents = contents;
            this.number = number;
            this.tokens = new ArrayList<Token>();
        }

        // Adding Tokens
        public void addTokens() {
            int increment;
            char c;
            Status status;

            for(int i = 0; i < contents.length();) {
                increment = 1;
                c = contents.charAt(i);

                // Space
                if(contents.charAt(i) == ' ')
                    ; // Skip spaces
                // Comma
                else if(c == ',')
                    tokens.add(new Token("comma", ","));
                // Key Word
                else if((status = this.isKeyword(i)).bool)
                    increment = status.increment;
                // Number
                else if((status = this.isNumber(i)).bool)
                    increment = status.increment;
                // Register
                else if((status = this.isRegister(i)).bool)
                    increment = status.increment;
                // Comment
                else if(c == '/' && contents.charAt(i + 1) == '/') {
                    break; // Ignore rest of line
                }
                // Else Dead
                else {
                    System.out.println("You are soooo!  There is a syntax error on line " + number + ": " + contents);
                    System.exit(0);
                }

                i += increment;
            }
        
        }

        public Status isKeyword(int i) {
            String input = contents;
            String[] keywords = {"addci", "addc", "addui", "addu", "addi", "add",
                                 "subi", "sub", "cmpi", "cmp", "andi", "and", "ori", "or",
                                 "xori", "xor", "not", "lshi", "lsh", "rsh",
                                 "arsh", "load", "stor", "beq", "bne", "bge", "bcs",
                                 "bcc", "bhi", "bls", "blo", "bhs", "bgt", "ble", "bfs", "bfc",
                                 "blt", "buc", "jal"};

            for (String keyword : keywords) {
                if (input.startsWith(keyword, i)) {
                    tokens.add(new Token("keyword", keyword));
                    return new Status(true, keyword.length());
                }
            }
            return new Status(false, 0);
        }

        public Status isNumber(int i) {
            char c = contents.charAt(i);
            int length = 0;
            // Negative Sign
            if(c == '-') {
                length++;
                if(i + length >= contents.length())
                    return new Status(false, 0);
                c = contents.charAt(i + length);
            }

            // Positive Number
            while(c >= 48 && c <= 57) {
                length++;
                if(i + length >= contents.length())
                    break;
                c = contents.charAt(i + length);
            }

            // If we found a number
            if((length > 0 && contents.charAt(i) != '-') || length > 1) {
                tokens.add(new Token("number", contents.substring(i, i + length)));
                return new Status(true, length);
            }
            else
                return new Status(false, 0);
        }

        public Status isRegister(int i) {
            char c = contents.charAt(i);
            int length = 0;

            if(c != 'r')
                return new Status(false, 0);
            length++;
            c = contents.charAt(i + length);

            if(c < 48 || c > 57)
                return new Status(false, 0);
            if(c != '1') {
                length++;
                tokens.add(new Token("register", contents.substring(i, i + length)));
                return new Status(true, length);
            } else {
                length++;
                if(i + length >= contents.length()) {
                    tokens.add(new Token("register", contents.substring(i, i + length)));
                    return new Status(true, length);
                } else {
                    c = contents.charAt(i + length);
                    if(c >= 48 && c <= 53) {
                        length++;
                        tokens.add(new Token("register", contents.substring(i, i + length)));
                        return new Status(true, length);
                    } else {
                        tokens.add(new Token("register", contents.substring(i, i + length)));
                        return new Status(true, length);
                    }
                }
            }
        }

        // Generating Hex
        public String verifySyntaxAndGenerateHex() {
            // Empty Lines or Comments
            if(tokens.size() == 0)
                return null;

            verifySyntax();

            return generateHex();
        }

        public void verifySyntax() {
            // First Token must be a keyword
            if(!tokens.get(0).type.equals("keyword")) {
                System.out.println("You can't be serious!  There is a syntax error on line " + number + ": " + contents);
                System.exit(0);
            }
            // add, addu, addc, sub, cmp, and, or, xor, lsh, rsh, arsh, load, stor, jal
            else if(tokens.get(0).value.equals("add") ||
                    tokens.get(0).value.equals("addu") ||
                    tokens.get(0).value.equals("addc") ||
                    tokens.get(0).value.equals("sub") ||
                    tokens.get(0).value.equals("cmp") ||
                    tokens.get(0).value.equals("and") ||
                    tokens.get(0).value.equals("or") ||
                    tokens.get(0).value.equals("xor") ||
                    tokens.get(0).value.equals("lsh") ||
                    tokens.get(0).value.equals("rsh") ||
                    tokens.get(0).value.equals("arsh") ||
                    tokens.get(0).value.equals("load") ||
                    tokens.get(0).value.equals("stor") ||
                    tokens.get(0).value.equals("jal")) {
                if(tokens.size() != 4 ||
                   !tokens.get(1).type.equals("register") ||
                   !tokens.get(2).type.equals("comma") ||
                   !tokens.get(3).type.equals("register")) {
                    System.out.println("For real brother?  You put an error on line " + number + ": " + contents);
                    System.exit(0);
                }
            }
            // addi, addui, addci, subi, cmpi, andi, ori, xori, lshi
            else if(tokens.get(0).value.equals("addi") ||
                    tokens.get(0).value.equals("addui") ||
                    tokens.get(0).value.equals("addci") ||
                    tokens.get(0).value.equals("subi") ||
                    tokens.get(0).value.equals("cmpi") ||
                    tokens.get(0).value.equals("andi") ||
                    tokens.get(0).value.equals("ori") ||
                    tokens.get(0).value.equals("xori") ||
                    tokens.get(0).value.equals("lshi")) {
                if(tokens.size() != 4 ||
                   !tokens.get(1).type.equals("register") ||
                   !tokens.get(2).type.equals("comma") ||
                   !tokens.get(3).type.equals("number")) {
                    System.out.println("You are done.  There is an error on line " + number + ": " + contents);
                    System.exit(0);
                }
            }
            // not
            else if(tokens.get(0).value.equals("not")) {
                if(tokens.size() != 2 ||
                   !tokens.get(1).type.equals("register")) {
                    System.out.println("Sorry man, the error has spoken and it is on line " + number + ": " + contents);
                    System.exit(0);
                }
            }
            // beq, bne, bge, bcs, bcc, bhi, bls, blo, bhs, bgt, ble, bfs, bfc, blt, buc
            else if(tokens.get(0).value.equals("beq") ||
                    tokens.get(0).value.equals("bne") ||
                    tokens.get(0).value.equals("bge") ||
                    tokens.get(0).value.equals("bcs") ||
                    tokens.get(0).value.equals("bcc") ||
                    tokens.get(0).value.equals("bhi") ||
                    tokens.get(0).value.equals("bls") ||
                    tokens.get(0).value.equals("blo") ||
                    tokens.get(0).value.equals("bhs") ||
                    tokens.get(0).value.equals("bgt") ||
                    tokens.get(0).value.equals("ble") ||
                    tokens.get(0).value.equals("bfs") ||
                    tokens.get(0).value.equals("bfc") ||
                    tokens.get(0).value.equals("blt") ||
                    tokens.get(0).value.equals("buc")) {
                if(tokens.size() != 2 ||
                   !tokens.get(1).type.equals("number")) {
                    System.out.println("Error detected on line " + number + ": " + contents);
                    System.exit(0);
                }
            }
        }

        public String generateHex() {
            Map<String, String> opcodeMap = new HashMap<String, String>();
            opcodeMap.put("add", "5");
            opcodeMap.put("addi", "5");
            opcodeMap.put("addu", "6");
            opcodeMap.put("addui", "6");
            opcodeMap.put("addc", "7");
            opcodeMap.put("addci", "7");
            opcodeMap.put("sub", "9");
            opcodeMap.put("subi", "9");
            opcodeMap.put("cmp", "b");
            opcodeMap.put("cmpi", "b");
            opcodeMap.put("and", "1");
            opcodeMap.put("andi", "1");
            opcodeMap.put("or", "2");
            opcodeMap.put("ori", "2");
            opcodeMap.put("xor", "3");
            opcodeMap.put("xori", "3");
            opcodeMap.put("lsh", "4");
            opcodeMap.put("rsh", "6");
            opcodeMap.put("arsh", "2");
            opcodeMap.put("beq", "0");
            opcodeMap.put("bne", "1");
            opcodeMap.put("bge", "d");
            opcodeMap.put("bcs", "2");
            opcodeMap.put("bcc", "3");
            opcodeMap.put("bhi", "4");
            opcodeMap.put("bls", "5");
            opcodeMap.put("blo", "a");
            opcodeMap.put("bhs", "b");
            opcodeMap.put("bgt", "6");
            opcodeMap.put("ble", "7");
            opcodeMap.put("bfs", "8");
            opcodeMap.put("bfc", "9");
            opcodeMap.put("blt", "c");
            opcodeMap.put("buc", "e");

            String instrType = tokens.get(0).value;

            String hexInstr = "";

            // add, addu, addc, sub, cmp, and, or, xor
            if(instrType.equals("add") ||
               instrType.equals("addu") ||
               instrType.equals("addc") ||
               instrType.equals("sub") ||
               instrType.equals("cmp") ||
               instrType.equals("and") ||
               instrType.equals("or") ||
               instrType.equals("xor")) {
                hexInstr += "0";
                hexInstr += regToHex(tokens.get(1).value);
                hexInstr += opcodeMap.get(instrType);
                hexInstr += regToHex(tokens.get(3).value);
            }
            // addi, addui, addci, subi
            else if(instrType.equals("addi") ||
                    instrType.equals("addui") ||
                    instrType.equals("addci") ||
                    instrType.equals("subi")) {
                        hexInstr += opcodeMap.get(instrType);
                        hexInstr += regToHex(tokens.get(1).value);
                        hexInstr += unsignedNumToHex(tokens.get(3).value, number, contents);
            }
            // cmpi, andi, ori, xori
            else if(instrType.equals("cmpi") ||
                    instrType.equals("andi") ||
                    instrType.equals("ori") ||
                    instrType.equals("xori")) {
                        hexInstr += opcodeMap.get(instrType);
                        hexInstr += regToHex(tokens.get(1).value);
                        hexInstr += signedNumToHex(tokens.get(3).value, number, contents, true);
            }
            // not
            else if(instrType.equals("not")) {
                hexInstr += "0";
                hexInstr += regToHex(tokens.get(1).value);
                hexInstr += "40";
            }
            // lsh, rsh, arsh
            else if(instrType.equals("lsh") ||
                    instrType.equals("rsh") ||
                    instrType.equals("arsh")) {
                        hexInstr += "8";
                        hexInstr += regToHex(tokens.get(1).value);
                        hexInstr += opcodeMap.get(instrType);
                        hexInstr += regToHex(tokens.get(3).value);
            }
            // lshi
            else if(instrType.equals("lshi")) {
                hexInstr += "8";
                hexInstr += regToHex(tokens.get(1).value);
                hexInstr += "0";
                int shiftAmmount = Integer.parseInt(tokens.get(3).value);
                if(shiftAmmount < 0){
                    System.out.println("Shift ammount cannot be negative.  This is on line " + number + ": " + contents);
                    System.exit(0);
                } else if(shiftAmmount > 16) {
                    System.out.println("Shift ammount cannot be greater than 16.  This is on line " + number + ": " + contents);
                    System.exit(0);
                }
                hexInstr += Integer.toHexString(shiftAmmount);
            }
            // load
            else if(instrType.equals("load")) {
                hexInstr += "4";
                hexInstr += regToHex(tokens.get(1).value);
                hexInstr += "0";
                hexInstr += regToHex(tokens.get(3).value);
            }
            // stor
            else if(instrType.equals("stor")) {
                hexInstr += "4";
                hexInstr += regToHex(tokens.get(1).value);
                hexInstr += "4";
                hexInstr += regToHex(tokens.get(3).value);
            }
            // beq, bne, bge, bcs, bcc, bhi, bls, blo, bhs, bgt, ble, bfs, bfc, blt, buc
            else if(instrType.equals("beq") ||
                    instrType.equals("bne") ||
                    instrType.equals("bge") ||
                    instrType.equals("bcs") ||
                    instrType.equals("bcc") ||
                    instrType.equals("bhi") ||
                    instrType.equals("bls") ||
                    instrType.equals("blo") ||
                    instrType.equals("bhs") ||
                    instrType.equals("bgt") ||
                    instrType.equals("ble") ||
                    instrType.equals("bfs") ||
                    instrType.equals("bfc") ||
                    instrType.equals("blt") ||
                    instrType.equals("buc")) {
                        hexInstr += "c";
                        hexInstr += opcodeMap.get(instrType);
                        hexInstr += signedNumToHex(tokens.get(1).value, number, contents, false);
            }
            // jal
            else if(instrType.equals("jal")) {
                hexInstr += "4";
                hexInstr += regToHex(tokens.get(1).value);
                hexInstr += "8";
                hexInstr += regToHex(tokens.get(3).value);
            }
            // Because we already verified syntax, this should never run
            else {
                System.out.println("This part of the program should never run.  If it does then there is a bug in the assembler code.  Contact the authorities if you ever see this. This is line " + number + ": " + contents);
                System.exit(0);
            }

            return hexInstr;
        }
    }

    public static class Token {
        public String type;
        public String value;

        public Token(String type, String value) {
            this.type = type;
            this.value = value;
        }
    }

    public static class Status {
        public boolean bool;
        public int increment;

        public Status(boolean bool, int increment) {
            this.bool = bool;
            this.increment = increment;
        }
    }
}

/**
 * add
 * addi
 * addu
 * addui
 * addc
 * addci
 * sub
 * subi
 * cmp
 * cmpi
 * and
 * andi
 * or
 * ori
 * xor
 * xori
 * not    0r40
 * lsh
 * lshi
 * rsh
 * arsh
 * load
 * stor
 * beq
 * bne
 * bge
 * bcs
 * bcc
 * bhi
 * bls
 * blo
 * bhs
 * bgt
 * ble
 * bfs
 * bfc
 * blt
 * buc
 * jal
 */