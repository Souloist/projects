using System;
using System.Collections.Generic;
using System.IO;
class Solution
{
    static void Main(String[] args)
    {
        int n = Int32.Parse(Console.ReadLine());
        string[] arr = new string[n];
        for (int i = 0; i < n; i++)
        {
            arr[i] = Console.ReadLine();
        }

        for (int i = 0; i < n; i++)
        {
            string s = arr[i];

            if (s.Length % 2 == 1)
            {
                Console.WriteLine("-1");
                continue;
            }

            Solve(s);

        }
    }

    static void Solve(string s)
    {
        int[] arr1 = new int[26];
        int[] arr2 = new int[26];

        string str1 = s.Substring(s.Length / 2);
        string str2 = s.Substring(0, s.Length / 2);

        // Guaranteed that str1.Length == str2.Length
        for(int i = 0; i < str1.Length; i++)
        {
            arr1[str1[i] - 'a']++;
            arr2[str2[i] - 'a']++;
        }

        int total = 0;
        for(int i = 0; i < 26; i++)
        {
            if(arr1[i] - arr2[i] > 0)
            {
                total += arr1[i] - arr2[i];
            }
        }

        Console.WriteLine(total);
        
    }
}
