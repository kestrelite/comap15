package javatest;

import java.util.Arrays;

public class JavaTest {
    public static final int N_SIZE = 10;
    public static final double[][] GRID = new double[N_SIZE*2+1][N_SIZE*2+1];
    //N_SIZE is middle row (50 -> 51st row -> middle
    public static final double DROP_RATE = 0.35;
    public static final double START_P = 1.0;
    
    public static void printArray(double[][] grid) {
        for (double[] grid1 : grid)
            System.out.println(Arrays.toString(grid1));
    }
    
    public static double artificialError(double radius) {
        return Math.random()*radius-(radius/2.0);
    }
    
    public static void main(String[] args) {
        for(int j = 0; j < 2*N_SIZE+1; j++) 
            GRID[N_SIZE][j] = START_P; 
        
        for(int i = N_SIZE+1; i < 2*N_SIZE+1; i++) {
            for(int j = 0; j < 2*N_SIZE+1; j++) {
                double new_rate = GRID[i-1][j]*DROP_RATE;
                new_rate *= 1+artificialError(0.2);
                System.out.println(new_rate);
                GRID[i][j] = Math.round(1000.0*new_rate)/1000.0;
            }
        }
        
        for(int i = 0; i < N_SIZE; i++) 
            for(int j = 0; j < 2*N_SIZE+1; j++)
                GRID[i][j] = GRID[2*N_SIZE-i][j];
        printArray(GRID);
    }
}
