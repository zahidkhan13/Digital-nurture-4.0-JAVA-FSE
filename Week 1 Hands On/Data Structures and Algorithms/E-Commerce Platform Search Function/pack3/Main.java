package pack3;

import java.util.Arrays;
import java.util.Comparator;

public class Main {
    public static void main(String[] args) {
        Product[] products = {
            new Product(101, "Shoes", "Footwear"),
            new Product(102, "Shirt", "Apparel"),
            new Product(103, "Laptop", "Electronics"),
            new Product(104, "Phone", "Electronics")
        };

        Product result1 = ProductSearch.linearSearch(products, "Laptop");
        System.out.println(result1 != null ? result1.productName : "Not Found");

        Arrays.sort(products, Comparator.comparing(p -> p.productName.toLowerCase()));
        Product result2 = ProductSearch.binarySearch(products, "Laptop");
        System.out.println(result2 != null ? result2.productName : "Not Found");
    }
}