using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HomeAssignment02
{
	class Program
	{
		static void Main(string[] args)
		{
			DBConnection dbConnection = new DBConnection();
			while(true)
			{
				var inputList = new List<string>();
				Console.WriteLine("Commands: 1. InsertCustomer, 2. InsertProduct, 3. UpdateProductPrice or Quit/Exit");
				var input = Console.ReadLine().ToLower();

				if(input == "quit" || input == "exit")
					break;

				switch(input)
				{
					case "insertcustomer":
					case "1":
						while(true)
						{
							//This should probably be something else than a console tbh...
							Console.WriteLine("Write the ID (string 5 letters and cant be empty), Company Name (string cant be empty), Contact Name(string), Contact Title(string), Address(string), City(string), Region(string), Postal Code(string), Country(string), Phone Number(string), Fax(string)");
							input = Console.ReadLine();
							inputList = input.Split(new string[] { ", " }, StringSplitOptions.None).ToList();
							if(inputList.Count() == 11 && inputList[0].Length == 5 && inputList[1].Length > 0)
								break;

							Console.WriteLine("All input required, and must be separated by ', '!\nFor example you can insert ABCDE, Nackademin, , , , Stockholm, , , ,08-1234567 , ");
						}
						
						dbConnection.InsertCustomer(inputList[0], inputList[1], inputList[2], inputList[3], inputList[4], inputList[5], inputList[6], inputList[7], inputList[8], inputList[9], inputList[10]);
						break;
					case "insertproduct":
					case "2":
						while(true)
						{
							Console.WriteLine("Write Productname (string, cant be empty), SupplierID (int), CategoryID(int), QuantityPerUnit(string), UnitPrice(decimal), UnitsInStock(int), UnitsOnOrder(int), ReorderLevel(int), Discontinued (false/true - if empty = false)");
							input = Console.ReadLine();
							inputList = input.Split(new string[] { ", " }, StringSplitOptions.None).ToList();
							if(inputList.Count() == 9 && inputList[0].Length > 0)
								break;

							Console.WriteLine("All input required, and must be separated by ', '!\nFor example you can insert Productname, 1, 12, 10 boxes x 20 bags, 12.50, 100, , , false");
						}
												
						dbConnection.InsertProduct(inputList[0], int.Parse(inputList[1]), int.Parse(inputList[2]), inputList[3], decimal.Parse(inputList[4]), int.Parse(inputList[5]), int.Parse(inputList[6]), int.Parse(inputList[7]), inputList[8].Trim().ToLower() == "true" ? true : false);
						break;
					case "updateproductprice":
					case "3":
						while(true)
						{
							Console.WriteLine("Write ProductID(int), UnitPrice(decimal)");
							input = Console.ReadLine();
							inputList = input.Split(new string[] { ", " }, StringSplitOptions.None).ToList();
							var test = inputList[0].All(char.IsDigit);
							var test2 = inputList[1].All(char.IsDigit);
							if(inputList.Count() == 2 && inputList[0].All(char.IsDigit) && inputList[1].All(char.IsDigit))
								break;

							Console.WriteLine("All input required, and must be separated by ', '!\nFor example you can insert 12, 99.90");
						}

						dbConnection.UpdateProductPrice(int.Parse(inputList[0]), decimal.Parse(inputList[1]));
						break;
					default:
						Console.WriteLine("Invalid Command!\n");
						break;
				}
				Console.WriteLine();
			}
		}
	}
}
