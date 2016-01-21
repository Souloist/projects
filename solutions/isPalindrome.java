public class checking {
    public static void main(String[] args) {
        String word = "";
        char[] word_array = word.toCharArray(); 
        System.out.println(istPalindrome(word_array));       
    }

    public static boolean istPalindrome(char[] word){
      int first = 0;
      int second = word.length - 1;
      while (second > fist) {
          if (word[first] != word[second]) {
              return false;
          }
          first++;
          second++;
      }
      return true;
  }
}
