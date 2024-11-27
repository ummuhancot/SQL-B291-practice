CREATE TABLE sirketler(
sirket_id INT PRIMARY KEY,
sirket_ismi VARCHAR(50),
memur_sayisi INT
);

INSERT INTO sirketler(sirket_id,sirket_ismi,memur_sayisi)
VALUES(100,'Nokia',1000),
(101,'Iphone',900),
(102,'Samsung',1200),
(103,'xiaomi',1500);

--soru 1 :en yüksek memurlar sayisi değerini getiriniz
select sirket_ismi,memur_sayisi from sirketler where memur_sayisi=(select max(memur_sayisi)from sirketler);--1500

(select max(memur_sayisi)from sirketler)--1500


--soru 2 : en düşük memurlar sayisi değerinin 1.5 katını getirin

select min(memur_sayisi)*1.5 from sirketler;--alias
select sirket_ismi as isim,memur_sayisi as sayi from sirketler;


--soru 3 : nokia ve xiaomi  memurlar sayisinin toplamını bulunuz
--1.yol
select sum(memur_sayisi)from sirketler where sirket_ismi='Nokia'or sirket_ismi='xiaomi';
--2.yol
select sum(memur_sayisi) as toplam from sirketler where sirket_ismi in('Nokia','xiaomi');


--soru 4 :Ortalama memurlar sayisi degerini bulunuz

select round(avg(memur_sayisi))from sirketler;

select * from sirketler;

--soru 5 :toplam sirket sayisini bulunuz
select count(sirket_id)from sirketler;

insert into sirketler values(104,'Sony');
insert into sirketler values(106,NULL,1350);

--soru 4 :Ortalama memurlar sayisi değerinden düşük olan memurlarin
--memur_sayisi değerlerini 400 artırın.

