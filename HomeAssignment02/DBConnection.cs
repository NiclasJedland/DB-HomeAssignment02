using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace HomeAssignment02
{
	public class DBConnection
	{
		string conString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;

		public void InsertCustomer(string CustomerID, string CompanyName, string ContactName, string ContactTitle, string Address, string City, string Region, string PostalCode, string Country, string Phone, string Fax)
		{
			using(var con = new SqlConnection(conString))
			{
				con.Open();
				using(var cmd = new SqlCommand("InsertCustomer", con))
				{
					cmd.CommandType = CommandType.StoredProcedure;

					cmd.Parameters.AddWithValue("@CustomerID", CustomerID);
					cmd.Parameters.AddWithValue("@CompanyName", CompanyName);
					cmd.Parameters.AddWithValue("@ContactName", ContactName);
					cmd.Parameters.AddWithValue("@ContactTitle", ContactTitle);
					cmd.Parameters.AddWithValue("@Address", Address);
					cmd.Parameters.AddWithValue("@City", City);
					cmd.Parameters.AddWithValue("@Region", Region);
					cmd.Parameters.AddWithValue("@PostalCode", PostalCode);
					cmd.Parameters.AddWithValue("@Country", Country);
					cmd.Parameters.AddWithValue("@Phone", Phone);
					cmd.Parameters.AddWithValue("@Fax", Fax);

					cmd.ExecuteNonQuery();
				}
			}
		}

		public void InsertProduct(string ProductName, int SupplierID, int CategoryID, string QuantityPerUnit, decimal UnitPrice, int UnitsInStock, int UnitsOnOrder, int ReorderLevel, bool Discontinued = false)
		{
			using(var con = new SqlConnection(conString))
			{
				con.Open();
				using(var cmd = new SqlCommand("InsertProduct", con))
				{
					cmd.CommandType = CommandType.StoredProcedure;

					cmd.Parameters.AddWithValue("@ProductName", ProductName);
					cmd.Parameters.AddWithValue("@SupplierID", SupplierID);
					cmd.Parameters.AddWithValue("@CategoryID", CategoryID);
					cmd.Parameters.AddWithValue("@QuantityPerUnit", QuantityPerUnit);
					cmd.Parameters.AddWithValue("@UnitPrice", UnitPrice);
					cmd.Parameters.AddWithValue("@UnitsInStock", UnitsInStock);
					cmd.Parameters.AddWithValue("@UnitsOnOrder", UnitsOnOrder);
					cmd.Parameters.AddWithValue("@ReorderLevel", ReorderLevel);
					cmd.Parameters.AddWithValue("@Discontinued", Discontinued);

					cmd.ExecuteNonQuery();
				}
			}
		}

		public void UpdateProductPrice(int ProductID, decimal UnitPrice)
		{
			using(var conn = new SqlConnection(conString))
			{
				conn.Open();

				using(var cmd = new SqlCommand("UpdateProductPrice", conn))
				{
					cmd.CommandType = CommandType.StoredProcedure;

					cmd.Parameters.AddWithValue("@ProductID", ProductID);
					cmd.Parameters.AddWithValue("@UnitPrice", UnitPrice);

					cmd.ExecuteNonQuery();
				}
			}
		}
	}
}
