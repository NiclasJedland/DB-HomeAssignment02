CREATE PROCEDURE [dbo].[InsertRegionAndTerritory] 
					(@TerritoryID NVARCHAR(20), @TerritoryDescription nchar(50), @RegionDescription nchar(50), @RegionID int output)
AS
	SET @RegionID =(SELECT MAX(r.RegionID) FROM Region r) + 1;
	INSERT INTO Region (RegionID, RegionDescription)
		VALUES (@RegionID, @RegionDescription)
	
	INSERT INTO Territories (RegionID, TerritoryDescription, TerritoryID)
		VALUES (@RegionID, @TerritoryDescription, @TerritoryID)

	SELECT MAX(RegionID) FROM Region