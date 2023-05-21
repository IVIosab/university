import java.util.*;

public class MosabMohamed {
    public static final String ANSI_GREEN_BACKGROUND = "\u001B[42m"; //to color the background to highlight the path
    public static final String ANSI_RESET = "\u001B[0m";


    public static ArrayList<ArrayList<Integer>> finalAgents;
    public static int finalPerception;
    public static ArrayList<ArrayList<String>> finalMap;
    public static ArrayList<ArrayList<Integer>> finalBacktrackPath = new ArrayList<>();
    public static ArrayList<ArrayList<Integer>> finalAStarPath = new ArrayList<>();

    public static int[][] algorithmParentX = new int[9][9];
    public static int[][] algorithmParentY = new int[9][9];
    public static int[][] algorithmVisited = new int[9][9];
    public static int[][] algorithmMemory = new int[9][9];
    public static ArrayList<ArrayList<Integer>> algorithmPath = new ArrayList<>();
    public static int algorithmShortest = Integer.MAX_VALUE;
    public static double elapsedBacktrackTimeSec, elapsedAStarTimeSec;


    /**
     * The entry point of application.
     *
     * @param args the input arguments
     */
    public static void main(String[] args) {
        finalAgents = mapInput();
        adjustCoordinates();
        finalPerception = scenarioInput();
        finalMap = makeMap();
        System.out.println("\nInitial Map: ");
        printMap(false, null);
        System.out.println("\n\n");

        //Backtrack //Done
        long startBacktrack = System.nanoTime();
        finalBacktrackPath = algorithmCases("Backtrack");
        long elapsedBacktrackTime = System.nanoTime() - startBacktrack;
        elapsedBacktrackTimeSec = elapsedBacktrackTime / 1000000000F;

        //A*
        long startAStar = System.nanoTime();
        finalAStarPath = algorithmCases("A*");
        long elapsedAStarTime = System.nanoTime() - startAStar;
        elapsedAStarTimeSec = elapsedAStarTime / 1000000000F;

        //output
        output();
    }

    /**
     * This method handles the map input whether it is manual or randomly generated
     *
     * @return ArrayList containing the coordinates of the agents
     */
    static ArrayList<ArrayList<Integer>> mapInput() {
        Scanner in = new Scanner(System.in);
        ArrayList<ArrayList<Integer>> agents = new ArrayList<>(); // the agents and objects locations 0-harry 1-argus 2-norris 3-book 4-cloak 5-exit
        System.out.println("Do you want to enter the locations of the agents and the objects manually? (yes,no)");
        String location;
        do {
            location = in.nextLine();
            location = location.toLowerCase();
            if (location.equals("yes")) {
                agents = manual();
            } else if (location.equals("no")) {
                agents = randomlyGenerated();
            } else {
                System.out.println("Invalid input, Please enter either 'yes' or 'no' without the single quotes");
            }
        } while (!(location.equals("yes") || location.equals("no")));
        return agents;
    }

    /**
     * This method handles the manual input where it shows the user the correct input format and checks if the
     * input given by the user follows the correct format or not
     *
     * @return ArrayList of the coordinates of the agents
     */
    static ArrayList<ArrayList<Integer>> manual() {
        Scanner in = new Scanner(System.in);
        ArrayList<ArrayList<Integer>> agents; // the agents and objects locations 0-harry 1-argus 2-norris 3-book 4-cloak 5-exit
        System.out.println("Please enter the locations in the following format :\n" +
                "[Harry_x,Harry_y][Argus_x,Argus_y][Norris_x,Norris_y][Book_x,Book_y][Cloak_x,Cloak_y][Exit_x,Exit_y]\n" +
                "Please keep in mind the following rules :\n" +
                "1 - The map is 9x9 where either x or y can be anything from 0 to 8 inclusive\n" +
                "2 - The Bottom-Left cell in the map is (0,0) and the Top-Right cell in the map is (8,8)\n" +
                "3 - The Exit cannot be in the same location as the Book or Mrs Norris or Argus Filch\n" +
                "4 - the inspector zone of Mrs Norris is a 3x3 square where Mrs Norris is in the middle\n" +
                "5 - the inspector zone of Argus Filch is a 5x5 square where Argus Filch is in the middle\n" +
                "6 - the Book and the Invisibility Cloak cannot be in any of the inspectors zones\n");
        int count;
        do {
            System.out.println("Please enter the locations : ");
            do {
                agents = new ArrayList<>();
                count = 0;
                String stringInput = in.nextLine();
                ArrayList<Integer> coordinates = new ArrayList<>();
                for (int i = 0; i < stringInput.length(); i++) {
                    char current = stringInput.charAt(i);
                    int number;
                    if (current != ']' && current != '[' && current != ',' && current != ' ') {
                        number = Character.getNumericValue(current);
                        coordinates.add(number);
                        count++;
                    }
                    if (coordinates.size() == 2) {
                        agents.add(coordinates);
                        coordinates = new ArrayList<>();
                    }
                }
                if (count != 12) {
                    System.out.println("Invalid input, Please enter the locations in the following format : \n" +
                            "[Harry_x,Harry_y][Argus_x,Argus_y][Norris_x,Norris_y][Book_x,Book_y][Cloak_x,Cloak_y][Exit_x,Exit_y]\n" +
                            "Example : [0,0][4,2][2,7][7,4][0,8][1,4]\n" +
                            "Explanation of the example : \n" +
                            "[0,0] - harry\n" +
                            "[4,2] - argus\n" +
                            "[2,7] - norris\n" +
                            "[7,4] - book\n" +
                            "[0,8] - cloak\n" +
                            "[1,4] - exit\n" +
                            "\n");
                }
            } while (count != 12);
            if (invalid(agents, 4)) {
                System.out.println("The input is invalid, Please refer to the rules written and re-enter the locations");
            }
        } while (invalid(agents, 4));
        return agents;
    }

    /**
     * This method handles the random generation of the agents coordinates.
     *
     * @return ArrayList of the coordinates of the agents
     */
    static ArrayList<ArrayList<Integer>> randomlyGenerated() {
        ArrayList<ArrayList<Integer>> agents = new ArrayList<>(); // the agents and objects locations 0-harry 1-argus 2-norris 3-book 4-cloak 5-exit

        //Harry initially in [0,0] as specified in the assignment
        ArrayList<Integer> harry = new ArrayList<>();
        harry.add(0);
        harry.add(0);
        agents.add(harry);

        //Argus
        ArrayList<Integer> argus = randomPair();
        agents.add(argus);

        //Norris
        ArrayList<Integer> norris = randomPair();
        agents.add(norris);

        ArrayList<ArrayList<Integer>> invalidityCheck = new ArrayList<>();
        for (int i = 0; i < agents.size(); i++) {
            invalidityCheck.add(agents.get(i));
        }

        //Book
        ArrayList<Integer> book;
        invalidityCheck.add(argus);
        do {
            invalidityCheck.remove(invalidityCheck.size() - 1);
            book = randomPair();
            invalidityCheck.add(book);
        } while (invalid(invalidityCheck, 1));
        agents.add(book);

        //Cloak
        invalidityCheck.add(argus);
        ArrayList<Integer> cloak;
        do {
            invalidityCheck.remove(invalidityCheck.size() - 1);
            cloak = randomPair();
            invalidityCheck.add(cloak);
        } while (invalid(invalidityCheck, 2));
        agents.add(cloak);

        //Exit
        invalidityCheck.add(argus);
        ArrayList<Integer> exit;
        do {
            invalidityCheck.remove(invalidityCheck.size() - 1);
            exit = randomPair();
            invalidityCheck.add(exit);
        } while (invalid(invalidityCheck, 3));
        agents.add(exit);

        return agents;
    }

    /**
     * This method randomly generates a Pair
     *
     * @return a random Pair
     */
    static ArrayList<Integer> randomPair() {
        Random rand = new Random();
        ArrayList<Integer> pair = new ArrayList<>();
        pair.add(rand.nextInt(9));
        pair.add(rand.nextInt(9));
        return pair;
    }

    /**
     * This method checks if the agents are properly coordinated based on the rules of the assignment.
     *
     * the mode parameter is used to see if the agents coordinates are correct in different stages instead of checking
     * at the end only
     *
     * @param agents the agents
     * @param mode   the mode
     * @return whether it's valid or not
     */
    static boolean invalid(ArrayList<ArrayList<Integer>> agents, int mode) {
        int argusX = agents.get(1).get(0), argusY = agents.get(1).get(1);
        int norrisX = agents.get(2).get(0), norrisY = agents.get(2).get(1);
        int argusX1 = Math.max(0, argusX - 2), argusX2 = Math.min(8, argusX + 2), argusY1 = Math.max(0, argusY - 2), argusY2 = Math.min(8, argusY + 2);
        int norrisX1 = Math.max(0, norrisX - 1), norrisX2 = Math.min(8, norrisX + 1), norrisY1 = Math.max(0, norrisY - 1), norrisY2 = Math.min(8, norrisY + 1);
        if (mode >= 1) { //if the book is in the inspectors zones then it is invalid
            int bookX = agents.get(3).get(0), bookY = agents.get(3).get(1);
            if ((bookX >= argusX1 && bookX <= argusX2 && bookY >= argusY1 && bookY <= argusY2) || (bookX >= norrisX1 && bookX <= norrisX2 && bookY >= norrisY1 && bookY <= norrisY2)) {
                return true;
            }
        }
        if (mode >= 2) { //if the cloak is in the inspectors zones then it is invalid
            int cloakX = agents.get(4).get(0), cloakY = agents.get(4).get(1);
            if ((cloakX >= argusX1 && cloakX <= argusX2 && cloakY >= argusY1 && cloakY <= argusY2) || (cloakX >= norrisX1 && cloakX <= norrisX2 && cloakY >= norrisY1 && cloakY <= norrisY2)) {
                return true;
            }
        }
        if (mode >= 3) { //if the exit is in the same location as the book or argus or norris then it is invalid
            int bookX = agents.get(3).get(0), bookY = agents.get(3).get(1);
            int exitX = agents.get(5).get(0), exitY = agents.get(5).get(1);
            if ((exitX == argusX && exitY == argusY) || (exitX == norrisX && exitY == norrisY) || (exitX == bookX && exitY == bookY)) {
                return true;
            }
        }
        return false;
    }

    /**
     * This method adjusts the coordinates of the agents.
     * x and y are switched because based on the example given in the assignment [a,b] (a) stands for which
     * column we are in and (b) stands for which row we are in.
     * y is substituted from 8 because we start from the bottom not the top.
     */
    static void adjustCoordinates() {
        for (int i = 0; i < finalAgents.size(); i++) {
            ArrayList<Integer> cur = finalAgents.get(i);
            int x = 8 - cur.get(1), y = cur.get(0);
            ArrayList<Integer> newCur = new ArrayList<>();
            newCur.add(x);
            newCur.add(y);
            finalAgents.set(i, newCur);
        }
    }

    /**
     * This method handles the scenario Input
     *
     * @return scenario
     */
    static int scenarioInput() {
        Scanner in = new Scanner(System.in);
        System.out.println("Please enter the Perception scenario (1,2)");
        int scenario;
        do {
            scenario = in.nextInt();
            if (scenario != 1 && scenario != 2) {
                System.out.println("Invalid input, Please enter either '1' or '2' without he single quotes");
            }
        } while (scenario != 1 && scenario != 2);
        return scenario;
    }

    /**
     * This method handles the making of the map
     *
     * where it returns an ArrayList of ArrayLists that is 9x9 containing the positions of the agents
     * in strings so it could be easily visualized
     *
     * @return The map
     */
    static ArrayList<ArrayList<String>> makeMap() {
        ArrayList<ArrayList<String>> map = new ArrayList<>();
        ArrayList<String> agentNames = new ArrayList<>();

        agentNames.add("H"); //Harry
        agentNames.add("A"); //Argus
        agentNames.add("N"); //Norris
        agentNames.add("B"); //Book
        agentNames.add("C"); //Cloak
        agentNames.add("E"); //Exit

        for (int i = 0; i < 9; i++) {//initialize the map with empty cells by adding 9 rows of empty cells
            ArrayList<String> row = new ArrayList<>();
            for (int j = 0; j < 9; j++) { //initialize a row with empty cells
                row.add("   ");
            }
            map.add(row);
        }

        for (int i = 0; i < finalAgents.size(); i++) {
            int x = finalAgents.get(i).get(0);
            int y = finalAgents.get(i).get(1);
            String cur = map.get(x).get(y);
            /*
            the spaces and complications are just for convenience while looking at the map in the console
             */
            cur = formatCell(cur, agentNames.get(i) + "");
            map.get(x).set(y, cur);
        }

        /*
        marking the inspectors zones.
         */
        for (int i = 1; i <= 2; i++) {
            int x = finalAgents.get(i).get(0), y = finalAgents.get(i).get(1);
            String cur;
            int leftX, rightX, leftY, rightY;
            if (i == 1) {//argus
                leftX = Math.max(x - 2, 0);
                rightX = Math.min(x + 2, 8);
                leftY = Math.max(y - 2, 0);
                rightY = Math.min(y + 2, 8);
            } else {//norris
                leftX = Math.max(x - 1, 0);
                rightX = Math.min(x + 1, 8);
                leftY = Math.max(y - 1, 0);
                rightY = Math.min(y + 1, 8);

            }

            for (int j = leftX; j <= rightX; j++) {
                for (int k = leftY; k <= rightY; k++) {
                    if (j == x && k == y) {
                        continue;
                    }
                    cur = map.get(j).get(k);
                    if (cur.indexOf('P') == -1 && cur.indexOf('N') == -1 && cur.indexOf('A') == -1) {
                        cur = formatCell(cur, "P");
                    }
                    map.get(j).set(k, cur);
                }
            }
        }

        return map;
    }

    /**
     * This method reformats the cells of the map after adding a new agent in it
     *
     * it formats it in a way to make the User Interface easier to understand
     *
     * @param cell     the cell
     * @param addition the addition
     * @return the new cell
     */
    static String formatCell(String cell, String addition) {
        String newCell = "";
        if (cell.charAt(1) != ' ') {
            newCell = cell.charAt(1) + " " + addition;
        } else if (cell.charAt(0) != ' ') {
            newCell = cell.charAt(0) + "" + cell.charAt(2) + "" + addition;
        } else {
            newCell = " " + addition + " ";
        }
        return newCell;
    }

    /**
     * This method prints the map with or without a path to be highlighted
     *
     * @param result if we want a path to be highlighted
     * @param path   the path
     */
    static void printMap(boolean result, ArrayList<ArrayList<Integer>> path) { //optimal
        for (int j = 0; j < 9; j++) {
            System.out.print("----");
        }
        System.out.println("-");
        for (int i = 0; i < 9; i++) {
            System.out.print("|");
            for (int j = 0; j < 9; j++) {
                if (result) {
                    boolean stepped = false;
                    for (int k = 0; k < path.size(); k++) {
                        if (i == path.get(k).get(0) && j == path.get(k).get(1)) {
                            stepped = true;
                            break;
                        }
                    }
                    if (stepped) {
                        System.out.print(ANSI_GREEN_BACKGROUND + finalMap.get(i).get(j) + ANSI_RESET + "|");
                    } else {
                        System.out.print(finalMap.get(i).get(j) + "|");
                    }
                } else {
                    System.out.print(finalMap.get(i).get(j) + "|");
                }
            }
            System.out.println();
            for (int j = 0; j < 9; j++) {
                System.out.print("----");
            }
            System.out.println("-");
        }
    }

    /**
     * This method handles the different cases for calling the algorithms
     * Different cases :
     *  1- Initial -> Book -> Exit
     *  2- Initial -> Book -> Cloak -> Exit
     *  3- Initial -> Cloak -> Book -> Exit
     * where based on the parameter algorithm we call another method for that algorithm while specifying the target we
     * want to reach
     *
     * @param algorithm the algorithm
     * @return the optimal path for the algorithm
     */
    static ArrayList<ArrayList<Integer>> algorithmCases(String algorithm) {
        ArrayList<ArrayList<Integer>> finalAlgorithmPath1 = new ArrayList<>();
        ArrayList<ArrayList<Integer>> finalAlgorithmPath2 = new ArrayList<>();
        ArrayList<ArrayList<Integer>> finalAlgorithmPath3 = new ArrayList<>();
        ArrayList<ArrayList<Integer>> finalAlgorithmPath = new ArrayList<>();
        //Initial -> Book -> Exit
        initialize();
        if (algorithm.equals("Backtrack")) {
            backtrackToTarget(finalAgents.get(0).get(0), finalAgents.get(0).get(1), 0, 0, 'B'); // from initial to book
        } else {
            aStar(finalAgents.get(0).get(0), finalAgents.get(0).get(1), 0, 'B', 0); // from initial to book
        }
        if (algorithmPath.size() > 0) {
            for (int i = algorithmPath.size() - 1; i >= 0; i--) {
                finalAlgorithmPath1.add(algorithmPath.get(i));
            }
            initialize();
            if (algorithm.equals("Backtrack")) {
                backtrackToTarget(finalAgents.get(3).get(0), finalAgents.get(3).get(1), 0, 0, 'E'); // from book to exit
            } else {
                aStar(finalAgents.get(3).get(0), finalAgents.get(3).get(1), 0, 'E', 1); // from book to exit maybe heuristics
            }
            if (algorithmPath.size() > 0) {
                for (int i = algorithmPath.size() - 2; i >= 0; i--) {
                    finalAlgorithmPath1.add(algorithmPath.get(i));
                }
            }
        }
        //Initial -> Book -> Cloak -> Exit
        initialize();
        if (algorithm.equals("Backtrack")) {
            backtrackToTarget(finalAgents.get(0).get(0), finalAgents.get(0).get(1), 0, 0, 'B'); // from initial to Book
        } else {
            aStar(finalAgents.get(0).get(0), finalAgents.get(0).get(1), 0, 'B', 0); // from initial to Book

        }
        if (algorithmPath.size() > 0) {
            for (int i = algorithmPath.size() - 1; i >= 0; i--) {
                finalAlgorithmPath2.add(algorithmPath.get(i));
            }
            initialize();
            if (algorithm.equals("Backtrack")) {
                backtrackToTarget(finalAgents.get(3).get(0), finalAgents.get(3).get(1), 0, 0, 'C'); // from Book to Cloak

            } else {
                aStar(finalAgents.get(3).get(0), finalAgents.get(3).get(1), 0, 'C', 0); // from Book to Cloak

            }
            if (algorithmPath.size() > 0) {
                for (int i = algorithmPath.size() - 2; i >= 0; i--) {
                    finalAlgorithmPath2.add(algorithmPath.get(i));
                }
                initialize();
                if (algorithm.equals("Backtrack")) {
                    backtrackToTarget(finalAgents.get(4).get(0), finalAgents.get(4).get(1), 0, 1, 'E'); // from Cloak to Exit

                } else {
                    aStar(finalAgents.get(4).get(0), finalAgents.get(4).get(1), 1, 'E', 1); // from Cloak to Exit maybe heuristics

                }
                if (algorithmPath.size() > 0) {
                    for (int i = algorithmPath.size() - 2; i >= 0; i--) {
                        finalAlgorithmPath2.add(algorithmPath.get(i));
                    }
                }
            }
        }
        //Initial -> Cloak -> Book -> Exit
        initialize();
        if (algorithm.equals("Backtrack")) {
            backtrackToTarget(finalAgents.get(0).get(0), finalAgents.get(0).get(1), 0, 0, 'C'); // from initial to Cloak

        } else {
            aStar(finalAgents.get(0).get(0), finalAgents.get(0).get(1), 0, 'C', 0); // from initial to Cloak

        }
        if (algorithmPath.size() > 0) {
            for (int i = algorithmPath.size() - 1; i >= 0; i--) {
                finalAlgorithmPath3.add(algorithmPath.get(i));
            }
            initialize();
            if (algorithm.equals("Backtrack")) {
                backtrackToTarget(finalAgents.get(4).get(0), finalAgents.get(4).get(1), 0, 1, 'B'); // from Cloak to Book

            } else {
                aStar(finalAgents.get(4).get(0), finalAgents.get(4).get(1), 1, 'B', 0); // from Cloak to Book

            }
            if (algorithmPath.size() > 0) {
                for (int i = algorithmPath.size() - 2; i >= 0; i--) {
                    finalAlgorithmPath3.add(algorithmPath.get(i));
                }
                initialize();
                if (algorithm.equals("Backtrack")) {
                    backtrackToTarget(finalAgents.get(3).get(0), finalAgents.get(3).get(1), 0, 1, 'E'); // from Book to Exit

                } else {
                    aStar(finalAgents.get(3).get(0), finalAgents.get(3).get(1), 1, 'E', 1); // from Book to Exit maybe heuristics

                }
                if (algorithmPath.size() > 0) {
                    for (int i = algorithmPath.size() - 2; i >= 0; i--) {
                        finalAlgorithmPath3.add(algorithmPath.get(i));
                    }
                }
            }
        }
        int bestSize = Integer.MAX_VALUE;
        ArrayList<ArrayList<ArrayList<Integer>>> validPaths = new ArrayList<>();
        if (validPath(finalAlgorithmPath1)) {
            validPaths.add(finalAlgorithmPath1);
        }
        if (validPath(finalAlgorithmPath2)) {
            validPaths.add(finalAlgorithmPath2);
        }
        if (validPath(finalAlgorithmPath3)) {
            validPaths.add(finalAlgorithmPath3);
        }
        for (int i = 0; i < validPaths.size(); i++) {
            if (validPaths.get(i).size() < bestSize) {
                bestSize = validPaths.get(i).size();
                finalAlgorithmPath = validPaths.get(i);
            }
        }
        return finalAlgorithmPath;
    }

    /**
     * This method is the backtracking algorithm.
     * it takes the current cell we are in and if we have the cloak or not and what target we want to reach
     * the parameter count is responsible for counting how many steps are we taking.
     *
     * The algorithm description:
     *  from our position we try to go to all valid positions next to us
     *  and if we go to another position that is valid, we do it recursively where we call the same
     *  method again but with the new position as the current one
     *
     *  after finishing all possible positions we can go to, we return back to the previous position (backtrack)
     *  and when we do so, we erase every information that was gained through going to that position.
     *
     * @param cur_x  the cur x
     * @param cur_y  the cur y
     * @param count  the count
     * @param cloak  the cloak
     * @param target the target
     */
    static void backtrackToTarget(int cur_x, int cur_y, int count, int cloak, char target) {
        if (count >= algorithmShortest) {
            return;
        }
        String cur = finalMap.get(cur_x).get(cur_y);
        boolean destination = false;
        for (int i = 0; i < cur.length(); i++) {
            if (cur.charAt(i) == target) {
                destination = true;
                break;
            }
        }
        if (destination) {
            if (count < algorithmShortest) {
                makeAlgorithmPath(cur_x, cur_y);
                algorithmShortest = count;
                return;
            }
        }

        algorithmVisited[cur_x][cur_y] = 1;
        int[] x = {1, 1, 1, 0, 0, -1, -1, -1};
        int[] y = {-1, 0, 1, 1, -1, -1, 0, 1};
        for (int i = 0; i < 8; i++) {
            int new_x = cur_x + x[i];
            int new_y = cur_y + y[i];
            if (isValid(new_x, new_y, cloak)) {
                if (algorithmMemory[new_x][new_y] > count + 1) {
                    algorithmMemory[new_x][new_y] = count + 1;
                    algorithmParentX[new_x][new_y] = cur_x;
                    algorithmParentY[new_x][new_y] = cur_y;
                    backtrackToTarget(new_x, new_y, count + 1, cloak, target);
                }
            }
        }
        algorithmVisited[cur_x][cur_y] = 0;
        algorithmParentX[cur_x][cur_y] = -1;
        algorithmParentY[cur_x][cur_y] = -1;
    }

    /**
     * This method is the A* algorithm.
     * it takes the current cell we are in and if we have the cloak or not and what target we want to reach and if there is a heuristic or not
     * the parameter count is responsible for counting how many steps are we taking.
     *
     * The algorithm description:
     *  we initialize a priority queue that we will use to prioritize which position do we go to based on our heuristic
     *  if there is no heuristic then the priority queue will prioritize going to the positions that were added to the queue first
     *
     *  when we go to any position we calculate our heuristic function which is the Euclidean distance from our position to the exit.
     *  in the case of there is no heuristic, we make our heuristic function to be our level in the tree, so we could prioritize older positions
     *  that have been added to the queue first.
     *
     *  we only use heuristics when our target is the exit because unlike the book or the cloak, we know the place of the exit
     *
     * @param init_x    the init x
     * @param init_y    the init y
     * @param cloak     the cloak
     * @param target    the target
     * @param heuristic the heuristic
     */
    static void aStar(int init_x, int init_y, int cloak, char target, int heuristic) {
        PriorityQueue<pair<Integer, Integer>> priQueue = new PriorityQueue<>();
        ArrayList<ArrayList<Integer>> queries = new ArrayList<>();
        ArrayList<Integer> queueCell = new ArrayList<>();
        if (heuristic == 1) {
            int heuristicValue = (int) Math.sqrt(Math.pow((init_x - finalAgents.get(5).get(0)), 2) + Math.pow((init_y - finalAgents.get(5).get(1)), 2));
            queueCell.add(heuristicValue);
        } else {
            queueCell.add(0);
        }
        queueCell.add(init_x);
        queueCell.add(init_y);
        queueCell.add(-1);
        queueCell.add(-1);
        queries.add(queueCell);
        pair<Integer, Integer> pr = new pair<>(queueCell.get(0),0);
        priQueue.add(pr);
        queries.add(queueCell);
        int dest_x = 0, dest_y = 0;
        boolean destination = false;
        while (!priQueue.isEmpty()) {
            pair<Integer,Integer> curPair = priQueue.poll();
            ArrayList<Integer> cur = queries.get(curPair.b);
            int priority = cur.get(0);
            int cur_x = cur.get(1);
            int cur_y = cur.get(2);
            int cur_par_x = cur.get(3);
            int cur_par_y = cur.get(4);
            if (!isValid(cur_x, cur_y, cloak)) {
                continue;
            }
            algorithmParentX[cur_x][cur_y] = cur_par_x;
            algorithmParentY[cur_x][cur_y] = cur_par_y;
            algorithmVisited[cur_x][cur_y] = 1;
            String curCell = finalMap.get(cur_x).get(cur_y);
            if (curCell.indexOf(target) != -1) {
                dest_x = cur_x;
                dest_y = cur_y;
                destination = true;
                break;
            }
            int[] x = {1, 1, 1, 0, 0, -1, -1, -1};
            int[] y = {-1, 0, 1, 1, -1, -1, 0, 1};
            for (int i = 0; i < 8; i++) {
                int new_x = cur_x + x[i];
                int new_y = cur_y + y[i];
                if (isValid(new_x, new_y, cloak)) {
                    ArrayList<Integer> newQueueCell = new ArrayList<>();
                    if (heuristic == 1) {
                        int heuristicValue = (int) Math.sqrt(Math.pow((new_x - finalAgents.get(5).get(0)), 2) + Math.pow((new_y - finalAgents.get(5).get(1)), 2));
                        newQueueCell.add(heuristicValue);
                    } else {
                        newQueueCell.add(priority + 1);
                    }
                    newQueueCell.add(new_x);
                    newQueueCell.add(new_y);
                    newQueueCell.add(cur_x);
                    newQueueCell.add(cur_y);
                    pair<Integer, Integer> newPair = new pair<>(newQueueCell.get(0),queries.size());
                    priQueue.add(newPair);
                    queries.add(newQueueCell);
                }
            }
        }
        if (destination) {
            makeAlgorithmPath(dest_x, dest_y);
        }
    }

    /**
     * This method checks if the given path is a valid one by checking if the first position is harry's initial position
     * and checking if the last position is the exit.
     *
     * @param path the path
     * @return whether it is valid or not
     */
    static boolean validPath(ArrayList<ArrayList<Integer>> path) {
        if (path.size() > 0) {
            if (path.get(0).get(0).equals(finalAgents.get(0).get(0)) && path.get(0).get(1).equals(finalAgents.get(0).get(1))) {//first cell is harry
                if (path.get(path.size() - 1).get(0).equals(finalAgents.get(5).get(0)) && path.get(path.size() - 1).get(1).equals(finalAgents.get(5).get(1))) {//last cell is exit
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * This method handles the generation of the path of any algorithm by utilizing the algorithmParent arrays.
     * where you give it the initial position and it makes the path based on adding its parent and then adding the parent's parent
     * and so on until we reach a cell that its parent is (-1,-1) which would be the starting cell
     *
     * @param x the x
     * @param y the y
     */
    static void makeAlgorithmPath(int x, int y) {
        ArrayList<ArrayList<Integer>> path = new ArrayList<>();
        while (x != -1 && y != -1) {
            ArrayList<Integer> pair = new ArrayList<>();
            pair.add(x);
            pair.add(y);
            path.add(pair);
            int newX = algorithmParentX[x][y];
            int newY = algorithmParentY[x][y];
            x = newX;
            y = newY;
        }
        algorithmPath = path;
    }

    /**
     * This method checks if the current position is valid or not
     * by checking if we are out of bounds or in an inspector zone without a cloak
     * or in an inspector cell
     *
     * @param x     the x
     * @param y     the y
     * @param cloak the cloak
     * @return whether it is valid or not
     */
    static boolean isValid(int x, int y, int cloak) {
        if (x < 0 || x > 8 || y < 0 || y > 8) { // out of the map
            return false;
        }
        if (algorithmVisited[x][y] == 1) { // already visited
            return false;
        }
        String cur = finalMap.get(x).get(y);
        if (cur.indexOf('A') != -1 || cur.indexOf('N') != -1 || (cur.indexOf('P') != -1 && cloak == 0)) { //inspector zone or cell
            return false;
        }
        return true;
    }

    /**
     * This method is used to initialize all variables that are used in the algorithms
     */
    static void initialize() {
        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                algorithmParentX[i][j] = algorithmParentY[i][j] = -1;
                algorithmMemory[i][j] = Integer.MAX_VALUE;
                algorithmVisited[i][j] = 0;
            }
        }
        algorithmShortest = Integer.MAX_VALUE;
        algorithmPath = new ArrayList<>();
    }

    /**
     * This method handles the output for the algorithms and the time it took each algorithm
     */
    static void output() {
        algorithmOutput("Backtrack", finalBacktrackPath);
        System.out.println("Time taken: " + String.format("%.12f", elapsedBacktrackTimeSec) + " seconds");

        System.out.println();

        algorithmOutput("A*", finalAStarPath);
        System.out.println("Time taken: " + String.format("%.12f", elapsedAStarTimeSec) + " seconds");

    }

    /**
     * This method handles the output of an algorithm by taking the name of the algorithm and the optimal path it reached
     * and then it outputs the path and its size and the outcome and it highlights the path on the map
     *
     * @param algorithmName      the algorithm name
     * @param finalAlgorithmPath the final algorithm path
     */
    static void algorithmOutput(String algorithmName, ArrayList<ArrayList<Integer>> finalAlgorithmPath) {
        System.out.println("Name of the Algorithm: " + algorithmName);
        String outcome;
        if (finalAlgorithmPath.size() != 0) {
            outcome = "Win";
        } else {
            outcome = "Lose";
        }
        System.out.println("Outcome: " + outcome);
        if (outcome.equals("Win")) {
            System.out.println("Number of steps: " + (finalAlgorithmPath.size() - 1));
            System.out.print("Path: ");
            for (int i = 0; i < finalAlgorithmPath.size(); i++) {
                ArrayList<Integer> cur = finalAlgorithmPath.get(i);
                System.out.print("[" + cur.get(1) + "," + (8 - cur.get(0)) + "]"); //we print y first and subtract x from 8 to readjust the coordinates. please refer to the function adjustCoordinates for more details
            }
            System.out.println();
            System.out.println("Highlighted path: ");
            printMap(true, finalAlgorithmPath);
        }
    }
}

/**
 * The type Pair.
 * it helps us in the A* implementation to use it in the priority queue
 *
 * @param <A> the type parameter
 * @param <B> the type parameter
 */
class pair<A, B> implements Comparable<pair<A, B>> {
    /**
     * The A.
     */
    public A a;
    /**
     * The B.
     */
    public B b;

    /**
     * Instantiates a new Pair.
     *
     * @param a the a
     * @param b the b
     */
    pair(A a, B b) {
        this.a = a;
        this.b = b;
    }

    /**
     * Instantiates a new Pair.
     */
    pair() {

    }

    @Override
    public int compareTo(pair<A, B> o) {
        return (Double.compare((Integer)this.a,(Integer)o.a));
    }
}