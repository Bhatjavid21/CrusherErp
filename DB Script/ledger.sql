USE [CrusherErp]
GO

/****** Object:  Table [dbo].[tbl_Ledger]    Script Date: 10/10/2021 11:35:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Ledger](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountId] [int] NOT NULL,
	[LedgerType] [nvarchar](100) NOT NULL,
	[LedgerTypeId] [nvarchar](100) NOT NULL,
	[CR] [money] NOT NULL,
	[DR] [money] NOT NULL,
	[Balance] [money] NOT NULL,
	[CreatedOn] [date] NOT NULL,
 CONSTRAINT [PK_tbl_Ledger] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tbl_Ledger] ADD  CONSTRAINT [DF_tbl_Ledger_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO


