defmodule Fuzzy do
   def my_lev(word, other, d) do
        levenshtein(word, other, d)
    end

   defp levenshtein(word, other_word, d) do
     cond do
       d == -1 -> :false
       String.length(word) > String.length(other_word) -> levenshtein(other_word, word, d)
       String.length(other_word) == 0 -> String.length(word) >= d
       true -> levenshtein(String.slice(word, 1, String.length(word)), String.slice(other_word, 1, String.length(other_word)), d-1) or #substitution
               levenshtein(word,  String.slice(other_word, 1, String.length(other_word)), d-1) or #insertion
               levenshtein(String.slice(word, 1, String.length(word)), other_word, d-1) or #deletion
               ( (String.at(word, 0) == String.at(other_word, 0)) and levenshtein(String.slice(word, 1, String.length(word)), String.slice(other_word, 1, String.length(other_word)), d) )
     end
    end
end

defmodule Sample do
  import Fuzzy

  def test_lev(word, other) do
    Fuzzy.my_lev(word, other, 2)
  end
end
