package pack4;

public class FinancialForecasting {
	public static double futureValueRecursive(double initialValue, double rate, int years) {
        if (years == 0) {
            return initialValue;
        }
        return futureValueRecursive(initialValue, rate, years - 1) * (1 + rate);
    }
	public static void main(String[] args) {
        double initial = 10000;
        double rate = 0.05;
        int years = 5;

        double result = futureValueRecursive(initial, rate, years);
        System.out.println("Future Value after " + years + " years: " + result);
    }
}
