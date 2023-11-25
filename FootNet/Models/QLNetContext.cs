using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace FootNet.Models
{
    public partial class QLNetContext : DbContext
    {
        public QLNetContext()
        {
        }

        public QLNetContext(DbContextOptions<QLNetContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Bill> Bills { get; set; } = null!;
        public virtual DbSet<Category> Categories { get; set; } = null!;
        public virtual DbSet<Fnb> Fnbs { get; set; } = null!;
        public virtual DbSet<Service> Services { get; set; } = null!;
        public virtual DbSet<Topping> Toppings { get; set; } = null!;
        public virtual DbSet<User> Users { get; set; } = null!;
        public virtual DbSet<Voucher> Vouchers { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {

                optionsBuilder.UseSqlServer("Data Source=LETHIHONGNGOT\\MSSQLSERVER04;Initial Catalog=QLNet;Integrated Security=True");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Bill>(entity =>
            {
                entity.HasKey(e => e.Billno);

                entity.ToTable("BILL");

                entity.HasIndex(e => e.Voucherid, "BILL_DISCOUNT_VOUCHER_FK");

                entity.HasIndex(e => e.Userid, "USER_ORDER_BILL_FK");

                entity.Property(e => e.Billno)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("BILLNO")
                    .IsFixedLength();

                entity.Property(e => e.Amountno).HasColumnName("AMOUNTNO");

                entity.Property(e => e.Daytime)
                    .HasColumnType("datetime")
                    .HasColumnName("DAYTIME");

                entity.Property(e => e.Description)
                    .HasMaxLength(100)
                    .HasColumnName("DESCRIPTION");

                entity.Property(e => e.Total).HasColumnName("TOTAL");

                entity.Property(e => e.Userid)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("USERID")
                    .IsFixedLength();

                entity.Property(e => e.Voucherid)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("VOUCHERID")
                    .IsFixedLength();

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Bills)
                    .HasForeignKey(d => d.Userid)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_BILL_USER_ORDE_USER");

                entity.HasOne(d => d.Voucher)
                    .WithMany(p => p.Bills)
                    .HasForeignKey(d => d.Voucherid)
                    .HasConstraintName("FK_BILL_BILL_DISC_VOUCHER");

                entity.HasMany(d => d.Fnbs)
                    .WithMany(p => p.Billnos)
                    .UsingEntity<Dictionary<string, object>>(
                        "BillSelectedFnb",
                        l => l.HasOne<Fnb>().WithMany().HasForeignKey("FnbId").OnDelete(DeleteBehavior.ClientSetNull).HasConstraintName("FK_BILL_SEL_BILL_SELE_FNB"),
                        r => r.HasOne<Bill>().WithMany().HasForeignKey("Billno").OnDelete(DeleteBehavior.ClientSetNull).HasConstraintName("FK_BILL_SEL_BILL_SELE_BILL"),
                        j =>
                        {
                            j.HasKey("Billno", "FnbId");

                            j.ToTable("BILL_SELECTED_FNB");

                            j.HasIndex(new[] { "FnbId" }, "BILL_SELECTED_FNB2_FK");

                            j.HasIndex(new[] { "Billno" }, "BILL_SELECTED_FNB_FK");

                            j.IndexerProperty<string>("Billno").HasMaxLength(50).IsUnicode(false).HasColumnName("BILLNO").IsFixedLength();

                            j.IndexerProperty<string>("FnbId").HasMaxLength(50).IsUnicode(false).HasColumnName("FNB_ID").IsFixedLength();
                        });
            });

            modelBuilder.Entity<Category>(entity =>
            {
                entity.ToTable("CATEGORY");

                entity.Property(e => e.Categoryid)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("CATEGORYID")
                    .IsFixedLength();

                entity.Property(e => e.Categoryname)
                    .HasMaxLength(50)
                    .HasColumnName("CATEGORYNAME");

                entity.Property(e => e.Type)
                    .HasMaxLength(50)
                    .HasColumnName("TYPE");
            });

            modelBuilder.Entity<Fnb>(entity =>
            {
                entity.ToTable("FNB");

                entity.HasIndex(e => e.Categoryid, "FNB_INHERENT_CATEGORY_FK");

                entity.Property(e => e.FnbId)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("FNB_ID")
                    .IsFixedLength();

                entity.Property(e => e.Amountno).HasColumnName("AMOUNTNO");

                entity.Property(e => e.Categoryid)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("CATEGORYID")
                    .IsFixedLength();

                entity.Property(e => e.FnbName)
                    .HasMaxLength(50)
                    .HasColumnName("FNB_NAME");

                entity.Property(e => e.Image).HasColumnName("IMAGE");

                entity.Property(e => e.Price).HasColumnName("PRICE");

                entity.Property(e => e.Status)
                    .HasMaxLength(50)
                    .HasColumnName("STATUS");

                entity.HasOne(d => d.Category)
                    .WithMany(p => p.Fnbs)
                    .HasForeignKey(d => d.Categoryid)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_FNB_FNB_INHER_CATEGORY");
            });

            modelBuilder.Entity<Service>(entity =>
            {
                entity.HasKey(e => e.Servicesid);

                entity.ToTable("SERVICES");

                entity.Property(e => e.Servicesid)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("SERVICESID")
                    .IsFixedLength();

                entity.Property(e => e.Description)
                    .HasMaxLength(100)
                    .HasColumnName("DESCRIPTION");

                entity.Property(e => e.Servicesname)
                    .HasMaxLength(50)
                    .HasColumnName("SERVICESNAME");
            });

            modelBuilder.Entity<Topping>(entity =>
            {
                entity.ToTable("TOPPING");

                entity.Property(e => e.Toppingid)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("TOPPINGID")
                    .IsFixedLength();

                entity.Property(e => e.Amount).HasColumnName("AMOUNT");

                entity.Property(e => e.Price).HasColumnName("PRICE");

                entity.Property(e => e.Toppingname)
                    .HasMaxLength(50)
                    .HasColumnName("TOPPINGNAME");

                entity.HasMany(d => d.Fnbs)
                    .WithMany(p => p.Toppings)
                    .UsingEntity<Dictionary<string, object>>(
                        "FnbSelectedTopping",
                        l => l.HasOne<Fnb>().WithMany().HasForeignKey("FnbId").OnDelete(DeleteBehavior.ClientSetNull).HasConstraintName("FK_FNB_SELE_FNB_SELEC_FNB"),
                        r => r.HasOne<Topping>().WithMany().HasForeignKey("Toppingid").OnDelete(DeleteBehavior.ClientSetNull).HasConstraintName("FK_FNB_SELE_FNB_SELEC_TOPPING"),
                        j =>
                        {
                            j.HasKey("Toppingid", "FnbId");

                            j.ToTable("FNB_SELECTED_TOPPING");

                            j.HasIndex(new[] { "FnbId" }, "FNB_SELECTED_TOPPING2_FK");

                            j.HasIndex(new[] { "Toppingid" }, "FNB_SELECTED_TOPPING_FK");

                            j.IndexerProperty<string>("Toppingid").HasMaxLength(50).IsUnicode(false).HasColumnName("TOPPINGID").IsFixedLength();

                            j.IndexerProperty<string>("FnbId").HasMaxLength(50).IsUnicode(false).HasColumnName("FNB_ID").IsFixedLength();
                        });
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.ToTable("USER");

                entity.Property(e => e.Userid)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("USERID")
                    .IsFixedLength();

                entity.Property(e => e.Email)
                    .HasMaxLength(50)
                    .HasColumnName("EMAIL");

                entity.Property(e => e.Isadmin).HasColumnName("ISADMIN");

                entity.Property(e => e.Password)
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasColumnName("PASSWORD")
                    .IsFixedLength();

                entity.Property(e => e.Phoneno)
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .HasColumnName("PHONENO")
                    .IsFixedLength();

                entity.Property(e => e.Pointafter).HasColumnName("POINTAFTER");

                entity.Property(e => e.Pointbefore).HasColumnName("POINTBEFORE");

                entity.Property(e => e.Pointtrans).HasColumnName("POINTTRANS");

                entity.Property(e => e.Username)
                    .HasMaxLength(50)
                    .HasColumnName("USERNAME");

                entity.HasMany(d => d.Services)
                    .WithMany(p => p.Users)
                    .UsingEntity<Dictionary<string, object>>(
                        "UserSelectedService",
                        l => l.HasOne<Service>().WithMany().HasForeignKey("Servicesid").OnDelete(DeleteBehavior.ClientSetNull).HasConstraintName("FK_USER_SEL_USER_SELE_SERVICES"),
                        r => r.HasOne<User>().WithMany().HasForeignKey("Userid").OnDelete(DeleteBehavior.ClientSetNull).HasConstraintName("FK_USER_SEL_USER_SELE_USER"),
                        j =>
                        {
                            j.HasKey("Userid", "Servicesid");

                            j.ToTable("USER_SELECTED_SERVICES");

                            j.HasIndex(new[] { "Servicesid" }, "USER_SELECTED_SERVICES2_FK");

                            j.HasIndex(new[] { "Userid" }, "USER_SELECTED_SERVICES_FK");

                            j.IndexerProperty<string>("Userid").HasMaxLength(50).IsUnicode(false).HasColumnName("USERID").IsFixedLength();

                            j.IndexerProperty<string>("Servicesid").HasMaxLength(50).IsUnicode(false).HasColumnName("SERVICESID").IsFixedLength();
                        });

                entity.HasMany(d => d.Vouchers)
                    .WithMany(p => p.Users)
                    .UsingEntity<Dictionary<string, object>>(
                        "UserCheckVoucher",
                        l => l.HasOne<Voucher>().WithMany().HasForeignKey("Voucherid").OnDelete(DeleteBehavior.ClientSetNull).HasConstraintName("FK_USER_CHE_USER_CHEC_VOUCHER"),
                        r => r.HasOne<User>().WithMany().HasForeignKey("Userid").OnDelete(DeleteBehavior.ClientSetNull).HasConstraintName("FK_USER_CHE_USER_CHEC_USER"),
                        j =>
                        {
                            j.HasKey("Userid", "Voucherid");

                            j.ToTable("USER_CHECK_VOUCHER");

                            j.HasIndex(new[] { "Voucherid" }, "USER_CHECK_VOUCHER2_FK");

                            j.HasIndex(new[] { "Userid" }, "USER_CHECK_VOUCHER_FK");

                            j.IndexerProperty<string>("Userid").HasMaxLength(50).IsUnicode(false).HasColumnName("USERID").IsFixedLength();

                            j.IndexerProperty<string>("Voucherid").HasMaxLength(50).IsUnicode(false).HasColumnName("VOUCHERID").IsFixedLength();
                        });
            });

            modelBuilder.Entity<Voucher>(entity =>
            {
                entity.ToTable("VOUCHER");

                entity.Property(e => e.Voucherid)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("VOUCHERID")
                    .IsFixedLength();

                entity.Property(e => e.Description)
                    .HasMaxLength(100)
                    .HasColumnName("DESCRIPTION");

                entity.Property(e => e.Discount).HasColumnName("DISCOUNT");

                entity.Property(e => e.Pointvoucher).HasColumnName("POINTVOUCHER");

                entity.Property(e => e.Status)
                    .HasMaxLength(50)
                    .HasColumnName("STATUS");

                entity.Property(e => e.Vouchername)
                    .HasMaxLength(50)
                    .HasColumnName("VOUCHERNAME");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
