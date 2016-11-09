CREATE TABLE [dbo].[Order Details] (
    [OrderID]   INT      NOT NULL,
    [ProductID] INT      NOT NULL,
    [UnitPrice] MONEY    CONSTRAINT [DF_Order_Details_UnitPrice] DEFAULT (0) NOT NULL,
    [Quantity]  SMALLINT CONSTRAINT [DF_Order_Details_Quantity] DEFAULT (1) NOT NULL,
    [Discount]  REAL     CONSTRAINT [DF_Order_Details_Discount] DEFAULT (0) NOT NULL,
    CONSTRAINT [PK_Order_Details] PRIMARY KEY CLUSTERED ([OrderID] ASC, [ProductID] ASC),
    CONSTRAINT [CK_Discount] CHECK ([Discount] >= 0 and [Discount] <= 1),
    CONSTRAINT [CK_Quantity] CHECK ([Quantity] > 0),
    CONSTRAINT [CK_UnitPrice] CHECK ([UnitPrice] >= 0),
    CONSTRAINT [FK_Order_Details_Orders] FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Orders] ([OrderID]),
    CONSTRAINT [FK_Order_Details_Products] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID])
);


GO
CREATE NONCLUSTERED INDEX [OrderID]
    ON [dbo].[Order Details]([OrderID] ASC);


GO
CREATE NONCLUSTERED INDEX [OrdersOrder_Details]
    ON [dbo].[Order Details]([OrderID] ASC);


GO
CREATE NONCLUSTERED INDEX [ProductID]
    ON [dbo].[Order Details]([ProductID] ASC);


GO
CREATE NONCLUSTERED INDEX [ProductsOrder_Details]
    ON [dbo].[Order Details]([ProductID] ASC);


GO

-- =============================================
-- Author:		Niclas
-- Create date: 
-- Description:	
-- =============================================
CREATE TRIGGER [dbo].[TriggerInsertedOrder] 
   ON [dbo].[Order Details] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	UPDATE Products
		SET UnitsInStock = UnitsInStock - i.Quantity
		FROM inserted i
		WHERE i.ProductID = Products.ProductID

END


GO
-- =============================================
-- Author:		Niclas
-- Create date: 
-- Description:	
-- =============================================
CREATE TRIGGER TriggerUpdateOrder 
   ON [Order Details] 
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here

	UPDATE Products
		SET UnitsInStock = UnitsInStock - (i.Quantity - d.Quantity)
		FROM inserted i
			INNER JOIN deleted d ON i.ProductID = d.ProductID
			INNER JOIN Products ON i.ProductID = Products.ProductID

END

GO
-- =============================================
-- Author:		Niclas
-- Create date: 
-- Description:	
-- =============================================
CREATE TRIGGER TriggerDeleteOrder 
   ON [Order Details] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here

	UPDATE Products
		SET UnitsInStock = UnitsInStock + d.Quantity
		FROM deleted d
		WHERE d.ProductID = Products.ProductID


END
