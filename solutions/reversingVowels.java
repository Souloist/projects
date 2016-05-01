public class reversingVowels{

    public static String reverseVowels(String s) {
        String vowels = "aeiouAEIOU";

        /* front pointer */
        int i = 0;

        /* back pointer */
        int j = s.length() - 1;

        char[] cArray = s.toCharArray();

        while(i < j){

            /* Increment the beginning pointer if it is not a vowel */
            if (!vowels.contains(String.valueOf(s.charAt(i)))){
                i++;
                continue;
            }

            /* Decrement the end pointer if it is not a vowel */
            if (!vowels.contains(String.valueOf(s.charAt(j)))){
                j--;
                continue;
            }

            /* swap */
            swap(cArray, i, j);

            i++;
            j--; 
        }
        
        /* returns string representation of char array */
        return String.valueOf(cArray);
    }

    public static void swap(char[] cArray, int i, int j){
        char temp = cArray[j];  
        cArray[j] = cArray[i];
        cArray[i] = temp;       
    }

    public static void main(String[] args){
        String s = "Make america Great Again";

        System.out.println(reverseVowels(s)); // should print "Mika Amareca Griet agean"
    }
}