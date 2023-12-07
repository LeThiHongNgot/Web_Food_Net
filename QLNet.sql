/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2016                    */
/* Created on:     02/10/2023 4:48:58 CH                        */
/*==============================================================*/
use master
go
create database QLNet
go
use QLNet

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BILL') and o.name = 'FK_BILL_BILL_DISC_VOUCHER')
alter table BILL
   drop constraint FK_BILL_BILL_DISC_VOUCHER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BILL') and o.name = 'FK_BILL_USER_ORDE_USER')
alter table BILL
   drop constraint FK_BILL_USER_ORDE_USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BILL_SELECTED_FNB') and o.name = 'FK_BILL_SEL_BILL_SELE_BILL')
alter table BILL_SELECTED_FNB
   drop constraint FK_BILL_SEL_BILL_SELE_BILL
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BILL_SELECTED_FNB') and o.name = 'FK_BILL_SEL_BILL_SELE_FNB')
alter table BILL_SELECTED_FNB
   drop constraint FK_BILL_SEL_BILL_SELE_FNB
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('FNB') and o.name = 'FK_FNB_FNB_INHER_CATEGORY')
alter table FNB
   drop constraint FK_FNB_FNB_INHER_CATEGORY
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('FNB_SELECTED_TOPPING') and o.name = 'FK_FNB_SELE_FNB_SELEC_TOPPING')
alter table FNB_SELECTED_TOPPING
   drop constraint FK_FNB_SELE_FNB_SELEC_TOPPING
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('FNB_SELECTED_TOPPING') and o.name = 'FK_FNB_SELE_FNB_SELEC_FNB')
alter table FNB_SELECTED_TOPPING
   drop constraint FK_FNB_SELE_FNB_SELEC_FNB
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('USER_CHECK_VOUCHER') and o.name = 'FK_USER_CHE_USER_CHEC_USER')
alter table USER_CHECK_VOUCHER
   drop constraint FK_USER_CHE_USER_CHEC_USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('USER_CHECK_VOUCHER') and o.name = 'FK_USER_CHE_USER_CHEC_VOUCHER')
alter table USER_CHECK_VOUCHER
   drop constraint FK_USER_CHE_USER_CHEC_VOUCHER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('USER_SELECTED_SERVICES') and o.name = 'FK_USER_SEL_USER_SELE_USER')
alter table USER_SELECTED_SERVICES
   drop constraint FK_USER_SEL_USER_SELE_USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('USER_SELECTED_SERVICES') and o.name = 'FK_USER_SEL_USER_SELE_SERVICES')
alter table USER_SELECTED_SERVICES
   drop constraint FK_USER_SEL_USER_SELE_SERVICES
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BILL')
            and   name  = 'BILL_DISCOUNT_VOUCHER_FK'
            and   indid > 0
            and   indid < 255)
   drop index BILL.BILL_DISCOUNT_VOUCHER_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BILL')
            and   name  = 'USER_ORDER_BILL_FK'
            and   indid > 0
            and   indid < 255)
   drop index BILL.USER_ORDER_BILL_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BILL')
            and   type = 'U')
   drop table BILL
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BILL_SELECTED_FNB')
            and   name  = 'BILL_SELECTED_FNB2_FK'
            and   indid > 0
            and   indid < 255)
   drop index BILL_SELECTED_FNB.BILL_SELECTED_FNB2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BILL_SELECTED_FNB')
            and   name  = 'BILL_SELECTED_FNB_FK'
            and   indid > 0
            and   indid < 255)
   drop index BILL_SELECTED_FNB.BILL_SELECTED_FNB_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BILL_SELECTED_FNB')
            and   type = 'U')
   drop table BILL_SELECTED_FNB
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CATEGORY')
            and   type = 'U')
   drop table CATEGORY
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('FNB')
            and   name  = 'FNB_INHERENT_CATEGORY_FK'
            and   indid > 0
            and   indid < 255)
   drop index FNB.FNB_INHERENT_CATEGORY_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('FNB')
            and   type = 'U')
   drop table FNB
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('FNB_SELECTED_TOPPING')
            and   name  = 'FNB_SELECTED_TOPPING2_FK'
            and   indid > 0
            and   indid < 255)
   drop index FNB_SELECTED_TOPPING.FNB_SELECTED_TOPPING2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('FNB_SELECTED_TOPPING')
            and   name  = 'FNB_SELECTED_TOPPING_FK'
            and   indid > 0
            and   indid < 255)
   drop index FNB_SELECTED_TOPPING.FNB_SELECTED_TOPPING_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('FNB_SELECTED_TOPPING')
            and   type = 'U')
   drop table FNB_SELECTED_TOPPING
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SERVICES')
            and   type = 'U')
   drop table SERVICES
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TOPPING')
            and   type = 'U')
   drop table TOPPING
go

if exists (select 1
            from  sysobjects
           where  id = object_id('"USER"')
            and   type = 'U')
   drop table "USER"
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('USER_CHECK_VOUCHER')
            and   name  = 'USER_CHECK_VOUCHER2_FK'
            and   indid > 0
            and   indid < 255)
   drop index USER_CHECK_VOUCHER.USER_CHECK_VOUCHER2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('USER_CHECK_VOUCHER')
            and   name  = 'USER_CHECK_VOUCHER_FK'
            and   indid > 0
            and   indid < 255)
   drop index USER_CHECK_VOUCHER.USER_CHECK_VOUCHER_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('USER_CHECK_VOUCHER')
            and   type = 'U')
   drop table USER_CHECK_VOUCHER
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('USER_SELECTED_SERVICES')
            and   name  = 'USER_SELECTED_SERVICES2_FK'
            and   indid > 0
            and   indid < 255)
   drop index USER_SELECTED_SERVICES.USER_SELECTED_SERVICES2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('USER_SELECTED_SERVICES')
            and   name  = 'USER_SELECTED_SERVICES_FK'
            and   indid > 0
            and   indid < 255)
   drop index USER_SELECTED_SERVICES.USER_SELECTED_SERVICES_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('USER_SELECTED_SERVICES')
            and   type = 'U')
   drop table USER_SELECTED_SERVICES
go

if exists (select 1
            from  sysobjects
           where  id = object_id('VOUCHER')
            and   type = 'U')
   drop table VOUCHER
go

/*==============================================================*/
/* Table: BILL                                                  */
/*==============================================================*/
create table BILL (
   BILLNO               char(50)             not null,
   USERID               char(50)             not null,
   VOUCHERID            char(50)             null,
   DAYTIME              datetime             null,
   DESCRIPTION          nvarchar (100)       null,
   AMOUNTNO             int                  null,
   TOTAL                float                null,
   constraint PK_BILL primary key (BILLNO)
)
go

/*==============================================================*/
/* Index: USER_ORDER_BILL_FK                                    */
/*==============================================================*/




create nonclustered index USER_ORDER_BILL_FK on BILL (USERID ASC)
go

/*==============================================================*/
/* Index: BILL_DISCOUNT_VOUCHER_FK                              */
/*==============================================================*/




create nonclustered index BILL_DISCOUNT_VOUCHER_FK on BILL (VOUCHERID ASC)
go

/*==============================================================*/
/* Table: BILL_SELECTED_FNB                                     */
/*==============================================================*/
create table BILL_SELECTED_FNB (
   BILLNO               char(50)             not null,
   FNB_ID               char(50)             not null,
   AMOUNT               int                  not null,
   constraint PK_BILL_SELECTED_FNB primary key (BILLNO, FNB_ID)
)
go

/*==============================================================*/
/* Index: BILL_SELECTED_FNB_FK                                  */
/*==============================================================*/




create nonclustered index BILL_SELECTED_FNB_FK on BILL_SELECTED_FNB (BILLNO ASC)
go

/*==============================================================*/
/* Index: BILL_SELECTED_FNB2_FK                                 */
/*==============================================================*/




create nonclustered index BILL_SELECTED_FNB2_FK on BILL_SELECTED_FNB (FNB_ID ASC)
go

/*==============================================================*/
/* Table: CATEGORY                                              */
/*==============================================================*/
create table CATEGORY (
   CATEGORYID           char(50)             not null,
   CATEGORYNAME         nvarchar (50)        null,
   TYPE                 nvarchar (50)        null,
   constraint PK_CATEGORY primary key (CATEGORYID)
)
go

/*==============================================================*/
/* Table: FNB                                                   */
/*==============================================================*/
create table FNB (
   FNB_ID               char(50)             not null,
   CATEGORYID           char(50)             not null,
   FNB_NAME             nvarchar (50)        null,
   AMOUNTNO             int                  null,
   PRICE                float                null,
   STATUS               nvarchar(50)         null,
   IMAGE                varbinary(max)       null,
   constraint PK_FNB primary key (FNB_ID)
)
go

/*==============================================================*/
/* Index: FNB_INHERENT_CATEGORY_FK                              */
/*==============================================================*/




create nonclustered index FNB_INHERENT_CATEGORY_FK on FNB (CATEGORYID ASC)
go

/*==============================================================*/
/* Table: FNB_SELECTED_TOPPING                                  */
/*==============================================================*/
create table FNB_SELECTED_TOPPING (
   TOPPINGID            char(50)             not null,
   FNB_ID               char(50)             not null,
   constraint PK_FNB_SELECTED_TOPPING primary key (TOPPINGID, FNB_ID)
)
go

/*==============================================================*/
/* Index: FNB_SELECTED_TOPPING_FK                               */
/*==============================================================*/




create nonclustered index FNB_SELECTED_TOPPING_FK on FNB_SELECTED_TOPPING (TOPPINGID ASC)
go

/*==============================================================*/
/* Index: FNB_SELECTED_TOPPING2_FK                              */
/*==============================================================*/




create nonclustered index FNB_SELECTED_TOPPING2_FK on FNB_SELECTED_TOPPING (FNB_ID ASC)
go

/*==============================================================*/
/* Table: SERVICES                                              */
/*==============================================================*/
create table SERVICES (
   SERVICESID           char(50)             not null,
   SERVICESNAME         nvarchar (50)        null,
   IMAGE                varbinary(max)       null,
   DESCRIPTION          nvarchar (100)       null,
   constraint PK_SERVICES primary key (SERVICESID)
)
go

/*==============================================================*/
/* Table: TOPPING                                               */
/*==============================================================*/
create table TOPPING (
   TOPPINGID            char(50)             not null,
   TOPPINGNAME          nvarchar(50)         null,
   AMOUNT               int                  null,
   PRICE                float                null,
   constraint PK_TOPPING primary key (TOPPINGID)
)
go

/*==============================================================*/
/* Table: "USER"                                                */
/*==============================================================*/
create table "USER" (
   USERID               char(50)             not null,
   USERNAME             nvarchar (50)        null,
   PASSWORD             char(30)             null,
   EMAIL                nvarchar(50)         null,
   PHONENO              char(10)             null,
   POINTBEFORE          int                  null,
   POINTTRANS           int                  null,
   POINTAFTER           int                  null,
   ISADMIN              bit                  null,
   constraint PK_USER primary key (USERID)
)
go

/*==============================================================*/
/* Table: USER_CHECK_VOUCHER                                    */
/*==============================================================*/
create table USER_CHECK_VOUCHER (
   USERID               char(50)             not null,
   VOUCHERID            char(50)             not null,
   constraint PK_USER_CHECK_VOUCHER primary key (USERID, VOUCHERID)
)
go

/*==============================================================*/
/* Index: USER_CHECK_VOUCHER_FK                                 */
/*==============================================================*/




create nonclustered index USER_CHECK_VOUCHER_FK on USER_CHECK_VOUCHER (USERID ASC)
go

/*==============================================================*/
/* Index: USER_CHECK_VOUCHER2_FK                                */
/*==============================================================*/




create nonclustered index USER_CHECK_VOUCHER2_FK on USER_CHECK_VOUCHER (VOUCHERID ASC)
go

/*==============================================================*/
/* Table: USER_SELECTED_SERVICES                                */
/*==============================================================*/
create table USER_SELECTED_SERVICES (
   USERID               char(50)             not null,
   SERVICESID           char(50)             not null,
   constraint PK_USER_SELECTED_SERVICES primary key (USERID, SERVICESID)
)
go

/*==============================================================*/
/* Index: USER_SELECTED_SERVICES_FK                             */
/*==============================================================*/




create nonclustered index USER_SELECTED_SERVICES_FK on USER_SELECTED_SERVICES (USERID ASC)
go

/*==============================================================*/
/* Index: USER_SELECTED_SERVICES2_FK                            */
/*==============================================================*/




create nonclustered index USER_SELECTED_SERVICES2_FK on USER_SELECTED_SERVICES (SERVICESID ASC)
go

/*==============================================================*/
/* Table: VOUCHER                                               */
/*==============================================================*/
create table VOUCHER (
   VOUCHERID            char(50)             not null,
   VOUCHERNAME          nvarchar(50)         null,
   DISCOUNT             int                  null,
   DESCRIPTION          nvarchar (100)       null,
   STATUS               nvarchar(50)         null,
   POINTVOUCHER         int                  null,
   constraint PK_VOUCHER primary key (VOUCHERID)
)
go

alter table BILL
   add constraint FK_BILL_BILL_DISC_VOUCHER foreign key (VOUCHERID)
      references VOUCHER (VOUCHERID)
go

alter table BILL
   add constraint FK_BILL_USER_ORDE_USER foreign key (USERID)
      references "USER" (USERID)
go

alter table BILL_SELECTED_FNB
   add constraint FK_BILL_SEL_BILL_SELE_BILL foreign key (BILLNO)
      references BILL (BILLNO)
go

alter table BILL_SELECTED_FNB
   add constraint FK_BILL_SEL_BILL_SELE_FNB foreign key (FNB_ID)
      references FNB (FNB_ID)
go

alter table FNB
   add constraint FK_FNB_FNB_INHER_CATEGORY foreign key (CATEGORYID)
      references CATEGORY (CATEGORYID)
go

alter table FNB_SELECTED_TOPPING
   add constraint FK_FNB_SELE_FNB_SELEC_TOPPING foreign key (TOPPINGID)
      references TOPPING (TOPPINGID)
go

alter table FNB_SELECTED_TOPPING
   add constraint FK_FNB_SELE_FNB_SELEC_FNB foreign key (FNB_ID)
      references FNB (FNB_ID)
go

alter table USER_CHECK_VOUCHER
   add constraint FK_USER_CHE_USER_CHEC_USER foreign key (USERID)
      references "USER" (USERID)
go

alter table USER_CHECK_VOUCHER
   add constraint FK_USER_CHE_USER_CHEC_VOUCHER foreign key (VOUCHERID)
      references VOUCHER (VOUCHERID)
go

alter table USER_SELECTED_SERVICES
   add constraint FK_USER_SEL_USER_SELE_USER foreign key (USERID)
      references "USER" (USERID)
go

alter table USER_SELECTED_SERVICES
   add constraint FK_USER_SEL_USER_SELE_SERVICES foreign key (SERVICESID)
      references SERVICES (SERVICESID)
go

------------------------------------------------------------------------------------------------------
USE [QLNet]
GO
INSERT [dbo].[VOUCHER] ([VOUCHERID], [VOUCHERNAME], [DISCOUNT], [DESCRIPTION], [STATUS], [POINTVOUCHER]) VALUES (N'VC001', N'Tân thủ', 5, N'Áp dụng cho mọi đơn hàng có giá trị từ 50.000đ trở lên. Có được khi lần đầu tạo tài khoản.', NULL, 0)
INSERT [dbo].[VOUCHER] ([VOUCHERID], [VOUCHERNAME], [DISCOUNT], [DESCRIPTION], [STATUS], [POINTVOUCHER]) VALUES (N'VC002', N'Trung kiên', 10, N'Áp dụng cho mọi đơn hàng.', NULL, 300)
INSERT [dbo].[VOUCHER] ([VOUCHERID], [VOUCHERNAME], [DISCOUNT], [DESCRIPTION], [STATUS], [POINTVOUCHER]) VALUES (N'VC003', N'Tinh anh', 20, N'Áp dụng cho mọi đơn hàng.', NULL, 600)
INSERT [dbo].[VOUCHER] ([VOUCHERID], [VOUCHERNAME], [DISCOUNT], [DESCRIPTION], [STATUS], [POINTVOUCHER]) VALUES (N'VC004', N'Trụ cột', 30, N'Áp dụng cho mọi đơn hàng.', NULL, 900)
INSERT [dbo].[VOUCHER] ([VOUCHERID], [VOUCHERNAME], [DISCOUNT], [DESCRIPTION], [STATUS], [POINTVOUCHER]) VALUES (N'VC005', N'Bang chủ', 50, N'Áp dụng cho mọi đơn hàng.', NULL, 1500)
GO
INSERT [dbo].[CATEGORY] ([CATEGORYID], [CATEGORYNAME], [TYPE]) VALUES (N'CT001', N'Thức Ăn', NULL)
INSERT [dbo].[CATEGORY] ([CATEGORYID], [CATEGORYNAME], [TYPE]) VALUES (N'CT002', N'Nước Uống', NULL)
GO
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'C001', N'CT001', N'Cơm Bò Viên Sa Tế', NULL, 30000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'C002', N'CT001', N'Cơm Chiên Trứng', NULL, 21000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'C003', N'CT001', N'Cơm Chiên Xúc Xích', NULL, 25000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'C004', N'CT001', N'Cơm Chiên Dương Châu', NULL, 31000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'C005', N'CT001', N'Cơm Chiên Cá Mặn', NULL, 31000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'C006', N'CT001', N'Cơm chiên Cánh Gà Chiên Giòn', NULL, 34000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'C007', N'CT001', N'Cơm Cá Hồi Sốt Cà', NULL, 29000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'C008', N'CT001', N'Cơm Bò Xào', NULL, 31000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'C009', N'CT001', N'Cơm Thịt Kho Trứng Cút', NULL, 27000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'C010', N'CT001', N'Cơm Thịt Rim Mặn', NULL, 29000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'C011', N'CT001', N'Cơm Phá Lấu', NULL, 27000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'CF001', N'CT002', N'Cà Phê Đen', NULL, 18000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'CF002', N'CT002', N'Cà Phê Sữa', NULL, 22000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'CF003', N'CT002', N'Bạc Xỉu', NULL, 25000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'CF004', N'CT002', N'Cacao Sữa (Nóng/Đá)', NULL, 22000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'CF005', N'CT002', N'Cacao Cà Phê Sữa (Nóng/Đá)', NULL, 25000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'CF006', N'CT002', N'Cà Phê Caramel', NULL, 27000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'CF007', N'CT002', N'Cà Phê Muối', NULL, 27000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D001', N'CT002', N'Nước Suối', NULL, 10000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D002', N'CT002', N'Coca', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D003', N'CT002', N'Revice', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D004', N'CT002', N'Revive Chanh Muối', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D005', N'CT002', N'Sting Dâu', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D006', N'CT002', N'Sting Vàng', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D007', N'CT002', N'Warrior Nho', NULL, 17000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D008', N'CT002', N'Warrior Dâu', NULL, 17000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D009', N'CT002', N'Redbull', NULL, 20000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D010', N'CT002', N'Trà Xanh C2', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D011', N'CT002', N'Ô Long Tea Plus', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D012', N'CT002', N'Cà Phê Wake Up 247', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D013', N'CT002', N'Mirinda Cam', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D014', N'CT002', N'Mirinda Xá Xị', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D015', N'CT002', N'Trà Xanh Không Độ', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D016', N'CT002', N'Trà Bí Đao', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D017', N'CT002', N'Twister Cam', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D018', N'CT002', N'Trà Đen C2 Đào', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D019', N'CT002', N'Monster Energy', NULL, 40000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D020', N'CT002', N'Monster Ultra Paradise', NULL, 40000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D021', N'CT002', N'Monster Energy Mango', NULL, 40000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D022', N'CT002', N'Monster Energy Ultra', NULL, 40000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D023', N'CT002', N'Sting Compact', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D024', N'CT002', N'Fuze Tea Đào Hạt Chia', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D025', N'CT002', N'Fuze Tea Chanh Dây Hạt Chia', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D026', N'CT002', N'Fuze Tea Chanh Sả', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D027', N'CT002', N'Aquarius', NULL, 10000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'D028', N'CT002', N'Compact vị Kiwi', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'L001', N'CT001', N'Lẩu Thái Viên', NULL, 33000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'L002', N'CT001', N'Lẩu Thái Xúc Xích', NULL, 27000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'M001', N'CT001', N'Mì Trộn Trứng', NULL, 21000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'M002', N'CT001', N'Mì Trộn Xúc Xích Xông Khói', NULL, 25000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'M003', N'CT001', N'Mì Trộn Xúc Xích Tóp Mỡ Đặc Biệt', NULL, 30000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'M004', N'CT001', N'Mì Trộn Trứng Tóp Mỡ Đặc Biệt', NULL, 26000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'M005', N'CT001', N'Mì Xào Bò', NULL, 31000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'M006', N'CT001', N'Mì Nước Trứng', NULL, 21000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'M007', N'CT001', N'Mì Nước Xúc Xích', NULL, 25000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'M008', N'CT001', N'Mì Bò Nước Hàn Quốc', NULL, 37000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'M009', N'CT001', N'Mì Hàn Quốc Trứng', NULL, 27000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'M010', N'CT001', N'Mì Trộn Khô Bò', NULL, 25000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'M011', N'CT001', N'Mì Nước Khô Bò', NULL, 25000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'M012', N'CT001', N'Mì Hàn Quốc Xúc Xích', NULL, 31000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'M013', N'CT001', N'Mì Tương Đen Trứng', NULL, 32000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'M014', N'CT001', N'Mì Tương Đen Xúc Xích Xông Khói', NULL, 36000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'MC001', N'CT002', N'Trà Đào Macchiato', NULL, 31000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'MC002', N'CT002', N'Trà Lài Macchiato', NULL, 31000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'MC003', N'CT002', N'Matcha Macchiato', NULL, 31000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'MT001', N'CT002', N'Trà Sữa Nguyên Lá', NULL, 27000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'MT002', N'CT002', N'Trà Sữa Lài', NULL, 27000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'MT003', N'CT002', N'Trà Sữa Khoai Môn', NULL, 27000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'MT004', N'CT002', N'Trà Sữa Matcha', NULL, 27000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'MT005', N'CT002', N'Trà Sữa Đào', NULL, 27000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'N001', N'CT001', N'Nui Xào Bò Viên Sa Tế', NULL, 30000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'N002', N'CT001', N'Nui Xào Bò', NULL, 31000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'N003', N'CT001', N'Nui Xào Xúc Xích', NULL, 25000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'N004', N'CT001', N'Nui Xào Trứng', NULL, 21000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SD001', N'CT002', N'Soda - Blue Ocean', NULL, 32000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SD002', N'CT002', N'Soda - Red Sunset', NULL, 32000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SD003', N'CT002', N'Soda - Chanh', NULL, 32000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SN001', N'CT001', N'Bò Viên Chiên', NULL, 21000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SN002', N'CT001', N'Cá Viên Chiên', NULL, 21000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SN003', N'CT001', N'Cánh Gà Chiên', NULL, 25000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SN004', N'CT001', N'Cơm Cháy Khô Gà', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SN005', N'CT001', N'Combo Ăn Vặt', NULL, 25000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SN006', N'CT001', N'Gà Rán Khoanh', NULL, 22000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SN007', N'CT001', N'Khoai Tây Chiên', NULL, 21000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SN008', N'CT001', N'Khoai Tây Chiên Lắc Phô Mai', NULL, 25000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SN009', N'CT001', N'Khoai Dẻo Lắc Phô Mai', NULL, 25000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SN010', N'CT001', N'Khô Bò Xé', NULL, 25000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SN011', N'CT001', N'Khô Gà Lá Chanh', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SN012', N'CT001', N'Xúc Xích Đức Xông Khói', NULL, 16000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SN013', N'CT001', N'Bắp Xào', NULL, 19000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SN014', N'CT001', N'Tóp mỡ sốt mắm tỏi ớt', NULL, 24000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SN015', N'CT001', N'Nem Chua Rán', NULL, 26000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SN016', N'CT001', N'Phô Mai Que', NULL, 24000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SN017', N'CT001', N'Xúc Xích Lốc Xoáy', NULL, 15000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'SN018', N'CT001', N'Gà popcorn lắc phô mai', NULL, 32000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'TE001', N'CT002', N'Trà Chanh', NULL, 18000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'TE002', N'CT002', N'Hồng Trà Tắc Mật Ong', NULL, 18000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'TE003', N'CT002', N'Sâm Dứa Sữa', NULL, 25000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'TE004', N'CT002', N'Trà Đào Cam Sả', NULL, 27000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'TE005', N'CT002', N'Trà Táo', NULL, 30000, NULL, NULL)
GO
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'TE006', N'CT002', N'Trà Đào Dưa Lưới', NULL, 30000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'TE007', N'CT002', N'Trà Ổi Hồng', NULL, 27000, NULL, NULL)
INSERT [dbo].[FNB] ([FNB_ID], [CATEGORYID], [FNB_NAME], [AMOUNTNO], [PRICE], [STATUS], [IMAGE]) VALUES (N'TE008', N'CT002', N'Trà Chanh Dây', NULL, 27000, NULL, NULL)
GO
INSERT [dbo].[TOPPING] ([TOPPINGID], [TOPPINGNAME], [AMOUNT], [PRICE]) VALUES (N'TP001', N'Cơm Thêm', NULL, 7000)
INSERT [dbo].[TOPPING] ([TOPPINGID], [TOPPINGNAME], [AMOUNT], [PRICE]) VALUES (N'TP002', N'Trứng Thêm', NULL, 6000)
INSERT [dbo].[TOPPING] ([TOPPINGID], [TOPPINGNAME], [AMOUNT], [PRICE]) VALUES (N'TP003', N'Xúc Xích Xông Khói Thêm', NULL, 13000)
INSERT [dbo].[TOPPING] ([TOPPINGID], [TOPPINGNAME], [AMOUNT], [PRICE]) VALUES (N'TP004', N'Mì Trộn Thêm', NULL, 8000)
INSERT [dbo].[TOPPING] ([TOPPINGID], [TOPPINGNAME], [AMOUNT], [PRICE]) VALUES (N'TP005', N'Mì Nước/Xào Thêm', NULL, 7000)
INSERT [dbo].[TOPPING] ([TOPPINGID], [TOPPINGNAME], [AMOUNT], [PRICE]) VALUES (N'TP006', N'Mì Hàn Quốc Thêm', NULL, 11000)
INSERT [dbo].[TOPPING] ([TOPPINGID], [TOPPINGNAME], [AMOUNT], [PRICE]) VALUES (N'TP007', N'Trân Châu Trắng 3Q', NULL, 6000)
INSERT [dbo].[TOPPING] ([TOPPINGID], [TOPPINGNAME], [AMOUNT], [PRICE]) VALUES (N'TP008', N'Trân Châu Đen 3Q', NULL, 6000)
INSERT [dbo].[TOPPING] ([TOPPINGID], [TOPPINGNAME], [AMOUNT], [PRICE]) VALUES (N'TP009', N'Thạch Táo', NULL, 6000)
INSERT [dbo].[TOPPING] ([TOPPINGID], [TOPPINGNAME], [AMOUNT], [PRICE]) VALUES (N'TP010', N'Hạt Thuỷ Tinh Dưa Lưới', NULL, 6000)
INSERT [dbo].[TOPPING] ([TOPPINGID], [TOPPINGNAME], [AMOUNT], [PRICE]) VALUES (N'TP011', N'Kem Chesse Phô Mai', NULL, 8000)
GO
INSERT [dbo].[SERVICES] ([SERVICESID], [SERVICESNAME], [IMAGE], [DESCRIPTION]) VALUES (N'SV001', N'Cập Nhật Game / Phần Mềm', NULL, NULL)
INSERT [dbo].[SERVICES] ([SERVICESID], [SERVICESNAME], [IMAGE], [DESCRIPTION]) VALUES (N'SV002', N'Tai Nghe Không Hoạt Động', NULL, NULL)
INSERT [dbo].[SERVICES] ([SERVICESID], [SERVICESNAME], [IMAGE], [DESCRIPTION]) VALUES (N'SV003', N'Màn Hình Không Hoạt Động', NULL, NULL)
INSERT [dbo].[SERVICES] ([SERVICESID], [SERVICESNAME], [IMAGE], [DESCRIPTION]) VALUES (N'SV004', N'Chuột Không Hoạt Động', NULL, NULL)
INSERT [dbo].[SERVICES] ([SERVICESID], [SERVICESNAME], [IMAGE], [DESCRIPTION]) VALUES (N'SV005', N'Bàn Phím Không Hoạt Động', NULL, NULL)
INSERT [dbo].[SERVICES] ([SERVICESID], [SERVICESNAME], [IMAGE], [DESCRIPTION]) VALUES (N'SV006', N'Vệ Sinh Bàn Phím', NULL, NULL)
INSERT [dbo].[SERVICES] ([SERVICESID], [SERVICESNAME], [IMAGE], [DESCRIPTION]) VALUES (N'SV007', N'Vui Lòng Vệ Sinh Chỗ Ngồi', NULL, NULL)
INSERT [dbo].[SERVICES] ([SERVICESID], [SERVICESNAME], [IMAGE], [DESCRIPTION]) VALUES (N'SV008', N'Lạnh Quá', NULL, NULL)
INSERT [dbo].[SERVICES] ([SERVICESID], [SERVICESNAME], [IMAGE], [DESCRIPTION]) VALUES (N'SV009', N'Nóng Quá', NULL, NULL)
INSERT [dbo].[SERVICES] ([SERVICESID], [SERVICESNAME], [IMAGE], [DESCRIPTION]) VALUES (N'SV010', N'Bên Cạnh Ồn Ào', NULL, NULL)
INSERT [dbo].[SERVICES] ([SERVICESID], [SERVICESNAME], [IMAGE], [DESCRIPTION]) VALUES (N'SV011', N'Xung Quanh Có Hút Thuốc', NULL, NULL)
INSERT [dbo].[SERVICES] ([SERVICESID], [SERVICESNAME], [IMAGE], [DESCRIPTION]) VALUES (N'SV012', N'Tôi Chưa Nhận Được Tiền Thối', NULL, NULL)
INSERT [dbo].[SERVICES] ([SERVICESID], [SERVICESNAME], [IMAGE], [DESCRIPTION]) VALUES (N'SV013', N'Đồ Ăn / Uống Lâu Quá', NULL, NULL)
INSERT [dbo].[SERVICES] ([SERVICESID], [SERVICESNAME], [IMAGE], [DESCRIPTION]) VALUES (N'SV014', N'Nhân Viên Thái Độ', NULL, NULL)
GO
INSERT [dbo].[USER] ([USERID]) VALUES ('U001')
INSERT [dbo].[USER] ([USERID]) VALUES ('U002')
INSERT [dbo].[USER] ([USERID]) VALUES ('U003')
INSERT [dbo].[USER] ([USERID]) VALUES ('U004')
INSERT [dbo].[USER] ([USERID]) VALUES ('U005')
INSERT [dbo].[USER] ([USERID]) VALUES ('U006')
INSERT [dbo].[USER] ([USERID]) VALUES ('U007')
INSERT [dbo].[USER] ([USERID]) VALUES ('U008')
INSERT [dbo].[USER] ([USERID]) VALUES ('U009')
INSERT [dbo].[USER] ([USERID]) VALUES ('U010')
INSERT [dbo].[USER] ([USERID]) VALUES ('U011')
GO
INSERT [dbo].[BILL] ([BILLNO], [USERID], [DAYTIME]) VALUES ('B001', 'U001', '2023-12-06')
INSERT [dbo].[BILL] ([BILLNO], [USERID], [DAYTIME]) VALUES ('B002', 'U001', '2023-12-06')
INSERT [dbo].[BILL] ([BILLNO], [USERID], [DAYTIME]) VALUES ('B003', 'U001', '2023-12-06')
INSERT [dbo].[BILL] ([BILLNO], [USERID], [DAYTIME]) VALUES ('B004', 'U002', '2023-12-06')
INSERT [dbo].[BILL] ([BILLNO], [USERID], [DAYTIME]) VALUES ('B005', 'U003', '2023-12-07')
INSERT [dbo].[BILL] ([BILLNO], [USERID], [DAYTIME]) VALUES ('B006', 'U004', '2023-12-07')
INSERT [dbo].[BILL] ([BILLNO], [USERID], [DAYTIME]) VALUES ('B007', 'U005', '2023-12-07')
INSERT [dbo].[BILL] ([BILLNO], [USERID], [DAYTIME]) VALUES ('B008', 'U006', '2023-12-07')
INSERT [dbo].[BILL] ([BILLNO], [USERID], [DAYTIME]) VALUES ('B009', 'U007', '2023-12-08')
INSERT [dbo].[BILL] ([BILLNO], [USERID], [DAYTIME]) VALUES ('B010', 'U008', '2023-12-08')
INSERT [dbo].[BILL] ([BILLNO], [USERID], [DAYTIME]) VALUES ('B011', 'U009', '2023-12-08')
INSERT [dbo].[BILL] ([BILLNO], [USERID], [DAYTIME]) VALUES ('B012', 'U010', '2023-12-08')
INSERT [dbo].[BILL] ([BILLNO], [USERID], [DAYTIME]) VALUES ('B013', 'U002', '2023-12-09')
INSERT [dbo].[BILL] ([BILLNO], [USERID], [DAYTIME]) VALUES ('B014', 'U004', '2023-12-09')
INSERT [dbo].[BILL] ([BILLNO], [USERID], [DAYTIME]) VALUES ('B015', 'U006', '2023-12-09')
INSERT [dbo].[BILL] ([BILLNO], [USERID], [DAYTIME]) VALUES ('B016', 'U008', '2023-12-09')
INSERT [dbo].[BILL] ([BILLNO], [USERID], [DAYTIME]) VALUES ('B017', 'U011', '2023-12-10')
INSERT [dbo].[BILL] ([BILLNO], [USERID], [DAYTIME]) VALUES ('B018', 'U001', '2023-12-10')
INSERT [dbo].[BILL] ([BILLNO], [USERID], [DAYTIME]) VALUES ('B019', 'U005', '2023-12-10')
INSERT [dbo].[BILL] ([BILLNO], [USERID], [DAYTIME]) VALUES ('B020', 'U005', '2023-12-10')
GO
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B001', 'M001', 2)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B002', 'M002', 1)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B003', 'C003', 2)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B004', 'N003', 3)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B005', 'SN018', 3)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B006', 'C006', 2)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B007', 'C004', 1)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B008', 'C011', 2)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B009', 'N002', 3)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B010', 'N004', 2)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B011', 'L002', 2)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B012', 'L001', 2)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B013', 'SN013', 5)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B014', 'SN002', 3)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B015', 'SN002', 5)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B016', 'N001', 3)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B017', 'SN001', 3)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B018', 'SN001', 4)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B019', 'SN008', 3)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B020', 'SN008', 5)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B001', 'D005', 3)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B002', 'D008', 4)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B002', 'TE008', 2)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B003', 'D019', 3)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B004', 'CF002', 2)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B005', 'D007', 3)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B006', 'D007', 4)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B007', 'M006', 2)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B008', 'M012', 3)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B008', 'TE005', 2)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B009', 'C010', 2)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B009', 'SD003', 3)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B010', 'D004', 2)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B011', 'SN012', 5)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B011', 'D017', 2)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B012', 'D002', 3)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B013', 'TE002', 2)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B014', 'SN010', 2)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B014', 'SN014', 2)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B014', 'D010', 3)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B015', 'SN016', 3)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B016', 'D026', 2)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B017', 'N004', 3)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B018', 'SN004', 3)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B018', 'D027', 4)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B019', 'MC003', 2)
INSERT [dbo].[BILL_SELECTED_FNB] VALUES ('B020', 'M004', 3)

Select FNB.FNB_ID,FNB.CATEGORYID,CATEGORY.CATEGORYNAME, FNB.FNB_NAME, SUM(BILL_SELECTED_FNB.AMOUNT) as 'TotalAmount', FNB.PRICE from BILL_SELECTED_FNB
join FNB on FNB.FNB_ID = BILL_SELECTED_FNB.FNB_ID
join CATEGORY on CATEGORY.CATEGORYID = FNB.CATEGORYID
group by FNB.FNB_ID,FNB.CATEGORYID,CATEGORY.CATEGORYNAME, FNB.FNB_NAME, FNB.PRICE

Select FNB.FNB_ID,FNB.CATEGORYID,CATEGORY.CATEGORYNAME, FNB.FNB_NAME, BILL_SELECTED_FNB.AMOUNT , FNB.PRICE from BILL_SELECTED_FNB
join FNB on FNB.FNB_ID = BILL_SELECTED_FNB.FNB_ID
join CATEGORY on CATEGORY.CATEGORYID = FNB.CATEGORYID


Select CATEGORY.CATEGORYID, CATEGORY.CATEGORYNAME, COUNT(CATEGORY.CATEGORYID) as 'TotalAmount' from CATEGORY
join FNB on FNB.CATEGORYID = CATEGORY.CATEGORYID
group by CATEGORY.CATEGORYID, CATEGORY.CATEGORYNAME

Select CATEGORY.CATEGORYNAME, FNB.FNB_ID, FNB_NAME, FNB.PRICE from FNB
join CATEGORY on CATEGORY.CATEGORYID = FNB.CATEGORYID


Select FNB.FNB_ID,FNB.CATEGORYID,CATEGORY.CATEGORYNAME, FNB.FNB_NAME, SUM(BILL_SELECTED_FNB.AMOUNT) as 'TotalAmount', FNB.PRICE, MAX(BILL.DAYTIME) as 'LatestDate' from BILL_SELECTED_FNB
join FNB on FNB.FNB_ID = BILL_SELECTED_FNB.FNB_ID
join CATEGORY on CATEGORY.CATEGORYID = FNB.CATEGORYID
join BILL on BILL.BILLNO = BILL_SELECTED_FNB.BILLNO
where CAST(BILL.DAYTIME as date) between '2023-12-07' and '2023-12-09' and FNB.FNB_ID = 'SN002'
group by FNB.FNB_ID,FNB.CATEGORYID,CATEGORY.CATEGORYNAME, FNB.FNB_NAME, FNB.PRICE