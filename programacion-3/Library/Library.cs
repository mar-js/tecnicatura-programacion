namespace Library
{
  public class Book
  {
    public string Title;
    public string Author;
    public string YearPublished;
    public bool Disponibility;

    public Book(string title, string author, string yearPublished, bool disponibility)
    {
      Title = title;
      Author = author;
      YearPublished = yearPublished;
      Disponibility = disponibility;
    }

    public string GetInfo()
    {
      return $"Title: {Title}, Author: {Author}, Year Published: {YearPublished}, Disponibility: {Disponibility}";
    }

    public void BorrowBook()
    {
      if (Disponibility)
      {
        Disponibility = false;
      }
    }

    public void ReturnBook()
    {
      Disponibility = true;
    }
  }
}