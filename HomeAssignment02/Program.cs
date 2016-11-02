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
				Console.WriteLine("Commands: 1. InsertCustomer, 2. InsertProduct, 3. UpdateProductPrice or Quit/Exit\n");
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
							Console.WriteLine("Write:\nCustomerID(string, 5 letters and cant be empty)\nCompany Name(string, cant be empty)\nContact Name(string)\nContact Title(string)\nAddress(string)\nCity(string)\nRegion(string)\nPostal Code(string)\nCountry(string)\nPhone Number(string)\nFax(string)");
							input = Console.ReadLine();
							inputList = input.Split(new string[] { ", " }, StringSplitOptions.None).ToList();
							if(inputList.Count() == 11 && inputList[0].Length == 5 && inputList[1].Length > 0)
								break;

							Console.WriteLine("All input required, and must be separated by ', '!\nFor example you can insert ABCDE, Nackademin, , , , Stockholm, , , ,08-1234567 , \n");
						}
						
						dbConnection.InsertCustomer(inputList[0], inputList[1], inputList[2], inputList[3], inputList[4], inputList[5], inputList[6], inputList[7], inputList[8], inputList[9], inputList[10]);
						break;
					case "insertproduct":
					case "2":
						while(true)
						{
							Console.WriteLine("Write:\nProductname(string, cant be empty)\nSupplierID (int)\nCategoryID(int)\nQuantityPerUnit(string)\nUnitPrice(decimal)\nUnitsInStock(int)\nUnitsOnOrder(int)\nReorderLevel(int)\nDiscontinued(false/true - if empty = false)");
							input = Console.ReadLine();
							inputList = input.Split(new string[] { ", " }, StringSplitOptions.None).ToList();
							if(inputList.Count() == 9 && inputList[0].Length > 0 && inputList[1].All(char.IsDigit) && inputList[2].All(char.IsDigit) && inputList[4].All(char.IsDigit) 
																				&& inputList[5].All(char.IsDigit) && inputList[6].All(char.IsDigit) && inputList[7].All(char.IsDigit))
								break;

							Console.WriteLine("All input required, and must be separated by ', '!\nFor example you can insert Productname, 1, 12, 10 boxes x 20 bags, 12.50, 100, , , false\n");
						}
												
						dbConnection.InsertProduct(inputList[0], int.Parse(inputList[1]), int.Parse(inputList[2]), inputList[3], decimal.Parse(inputList[4]), int.Parse(inputList[5]), int.Parse(inputList[6]), int.Parse(inputList[7]), inputList[8].Trim().ToLower() == "true" ? true : false);
						break;
					case "updateproductprice":
					case "3":
						while(true)
						{
							Console.WriteLine("Write:\nProductID(int)\nUnitPrice(decimal)");
							input = Console.ReadLine();
							inputList = input.Split(new string[] { ", " }, StringSplitOptions.None).ToList();
							var test = inputList[0].All(char.IsDigit);
							var test2 = inputList[1].All(char.IsDigit);
							if(inputList.Count() == 2 && inputList[0].All(char.IsDigit) && inputList[1].All(char.IsDigit))
								break;

							Console.WriteLine("All input required, and must be separated by ', '!\nFor example you can insert 12, 99.90\n");
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
