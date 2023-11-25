/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2016                    */
/* Created on:     23/09/2023 1:45:15 CH                        */
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

if exists (select 1
            from  sysindexes
           where  id    = object_id('USER_CHECK_VOUCHER')
            and   name  = 'USER_CHECK_VOUCHER2_FK'
            and   indid > 0
            and   indid < 255)
   drop index USER_CHECK_VOUCHER.USER_CHECK_VOUCHER2_FK

if exists (select 1
            from  sysindexes
           where  id    = object_id('USER_CHECK_VOUCHER')
            and   name  = 'USER_CHECK_VOUCHER_FK'
            and   indid > 0
            and   indid < 255)
   drop index USER_CHECK_VOUCHER.USER_CHECK_VOUCHER_FK

if exists (select 1
            from  sysobjects
           where  id = object_id('USER_CHECK_VOUCHER')
            and   type = 'U')
   drop table USER_CHECK_VOUCHER

if exists (select 1
            from  sysindexes
           where  id    = object_id('USER_SELECTED_SERVICES')
            and   name  = 'USER_SELECTED_SERVICES2_FK'
            and   indid > 0
            and   indid < 255)
   drop index USER_SELECTED_SERVICES.USER_SELECTED_SERVICES2_FK

if exists (select 1
            from  sysindexes
           where  id    = object_id('USER_SELECTED_SERVICES')
            and   name  = 'USER_SELECTED_SERVICES_FK'
            and   indid > 0
            and   indid < 255)
   drop index USER_SELECTED_SERVICES.USER_SELECTED_SERVICES_FK

if exists (select 1
            from  sysobjects
           where  id = object_id('USER_SELECTED_SERVICES')
            and   type = 'U')
   drop table USER_SELECTED_SERVICES

if exists (select 1
            from  sysobjects
           where  id = object_id('VOUCHER')
            and   type = 'U')
   drop table VOUCHER

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

/*==============================================================*/
/* Index: USER_ORDER_BILL_FK                                    */
/*==============================================================*/

create nonclustered index USER_ORDER_BILL_FK on BILL (USERID ASC)

/*==============================================================*/
/* Index: BILL_DISCOUNT_VOUCHER_FK                              */
/*==============================================================*/

create nonclustered index BILL_DISCOUNT_VOUCHER_FK on BILL (VOUCHERID ASC)

/*==============================================================*/
/* Table: BILL_SELECTED_FNB                                     */
/*==============================================================*/
create table BILL_SELECTED_FNB (
   BILLNO               char(50)             not null,
   FNB_ID               char(50)             not null,
   constraint PK_BILL_SELECTED_FNB primary key (BILLNO, FNB_ID)
)

/*==============================================================*/
/* Index: BILL_SELECTED_FNB_FK                                  */
/*==============================================================*/

create nonclustered index BILL_SELECTED_FNB_FK on BILL_SELECTED_FNB (BILLNO ASC)

/*==============================================================*/
/* Index: BILL_SELECTED_FNB2_FK                                 */
/*==============================================================*/

create nonclustered index BILL_SELECTED_FNB2_FK on BILL_SELECTED_FNB (FNB_ID ASC)

/*==============================================================*/
/* Table: CATEGORY                                              */
/*==============================================================*/
create table CATEGORY (
   CATEGORYID           char(50)             not null,
   CATEGORYNAME         nvarchar (50)        null,
   TYPE                 nvarchar (50)        null,
   constraint PK_CATEGORY primary key (CATEGORYID)
)

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

/*==============================================================*/
/* Index: FNB_INHERENT_CATEGORY_FK                              */
/*==============================================================*/

create nonclustered index FNB_INHERENT_CATEGORY_FK on FNB (CATEGORYID ASC)

/*==============================================================*/
/* Table: FNB_SELECTED_TOPPING                                  */
/*==============================================================*/
create table FNB_SELECTED_TOPPING (
   TOPPINGID            char(50)             not null,
   FNB_ID               char(50)             not null,
   constraint PK_FNB_SELECTED_TOPPING primary key (TOPPINGID, FNB_ID)
)


/*==============================================================*/
/* Index: FNB_SELECTED_TOPPING_FK                               */
/*==============================================================*/

create nonclustered index FNB_SELECTED_TOPPING_FK on FNB_SELECTED_TOPPING (TOPPINGID ASC)

/*==============================================================*/
/* Index: FNB_SELECTED_TOPPING2_FK                              */
/*==============================================================*/

create nonclustered index FNB_SELECTED_TOPPING2_FK on FNB_SELECTED_TOPPING (FNB_ID ASC)

/*==============================================================*/
/* Table: SERVICES                                              */
/*==============================================================*/
create table SERVICES (
   SERVICESID           char(50)             not null,
   SERVICESNAME         nvarchar (50)        null,
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

