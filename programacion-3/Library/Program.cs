using System;
using Library;

class Program
{
  static void Main(string[] args)
  {
    Book book1 = new Book("1984", "George Orwell", "1949", true);
    Book book2 = new Book("To Kill a Mockingbird", "Harper Lee", "1960", true);
    Book book3 = new Book("The Great Gatsby", "F. Scott Fitzgerald", "1925", false);

    List<Book> books = new List<Book> { book1, book2, book3 };

    foreach (var book in books)
    {
      Console.WriteLine(book.GetInfo());
    }
  }
}