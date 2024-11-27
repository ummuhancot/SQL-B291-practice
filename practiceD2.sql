SELECT * FROM sirketler;

DELETE FROM sirketler;

INSERT INTO sirketler(sirket_id,sirket_ismi,memur_sayisi)
VALUES(100,'Nokia',1000),
(101,'Iphone',900),
(102,'Samsung',1200),
(103,'xiaomi',1500);

--soru 1 :Samsungun memurlar sayisini en yüksek memurlar sayisi değerine esitleyin

SELECT MAX (memur_sayisi)
FROM sirketler;

UPDATE sirketler
SET memur_sayisi = (SELECT MAX (memur_sayisi)FROM sirketler)
WHERE sirket_ismi = 'Samsung';

SELECT * FROM sirketler;

--soru 2 :Nokia sirketinin memurlar sayisi değerini en düşük memurlar sayisi değerinin 1.5 katına esitleyin

UPDATE sirketler
SET memur_sayisi = (SELECT MIN (memur_sayisi)FROM sirketler ) * 1.5
WHERE sirket_ismi = 'Nokia';


--soru 3 :Iphonenin memurlar sayisini nokia ve xiaomi sirketlerinin memurlar sayisinin toplamına esıtleyın
SELECT SUM (memur_sayisi) FROM sirketler
WHERE sirket_ismi IN ('xiaomi','Nokia');

UPDATE sirketler 
SET memur_sayisi = (SELECT SUM (memur_sayisi) FROM sirketler
WHERE sirket_ismi IN ('xiaomi','Nokia'))
WHERE sirket_ismi = 'Iphone';

SELECT * FROM sirketler;


--soru 4 :Ortalama memurlar sayisi değerinden düşük olan memurlarin memur_sayisi değerlerini 400 artırın.
UPDATE sirketler 
SET memur_sayisi = memur_sayisi + 400 
WHERE memur_sayisi < (SELECT AVG (memur_sayisi) FROM sirketler);



CREATE TABLE memurlar (
    memurlar_id Int PRIMARY Key,
    ad VARCHAR(100),
    sehir VARCHAR(50),
    sirket_ismi VARCHAR(100),
    calisma_performanslari VARCHAR(255)
);

INSERT INTO memurlar (memurlar_id,ad, sehir, sirket_ismi, calisma_performanslari)
VALUES
    (100,'Ali Yılmaz', 'Ankara', 'Samsung', 'Ortalama 67'),
    (101,'Ayşe Demir', 'İstanbul', 'Iphone', 'Ortalama 72'),
    (102,'Mehmet Kaya', 'İzmir', 'xiaomi', 'Ortalama 55'),
    (103,'Ahmet Can', 'Bursa' ,'Nokia', 'Ortalama 98'),
    (104,'Ahmet Kadir'  ,'Ankara',  'Nokia' ,'Ortalama 92.5'),
    (105,'Fatma Güzel'  ,'Giresun', 'Samsung'   ,'Ortalama 92.5'),
    (106,'Furkan Yılmaz', 'İzmir', 'xiaomi', 'Ortalama 99');


	SELECT * FROM memurlar;
	SELECT * FROM sirketler;

-- SORU5: memurlar sayisi 2200’den cok olan sirketlerin ve
--bu sirkette calisanlarin isimlerini ve calisma performanslarini listeleyin.

insert into sirketler values(104,'Philips',3000);

SELECT ad,calisma_performanslari
FROM memurlar
WHERE sirket_ismi = (SELECT sirket_ismi FROM sirketler WHERE memur_sayisi>2200);
	
-- SORU6: Ankara'da memurlari olan sirketlerin
--sirket id'lerini ve memurlar sayilarini listeleyiniz

SELECT sirket_ismi FROM memurlar 
WHERE sehir = 'Ankara';

SELECT sirket_id,memur_sayisi FROM sirketler
WHERE sirket_ismi IN (SELECT sirket_ismi FROM memurlar 
WHERE sehir = 'Ankara');

--Soru 7: eger giresunda bir tane bile memur varsa tum sirketleri yazdirin

SELECT * FROM memurlar;
SELECT * FROM sirketler;

	
SELECT * FROM memurlar 
WHERE sehir = 'Giresun';

SELECT * FROM sirketler
WHERE EXISTS (SELECT * FROM memurlar 
WHERE sehir = 'Giresun');


CREATE TABLE sales (
    id INT PRIMARY KEY,       -- Satış ID'si (her satışın benzersiz tanımlayıcısı)
    sales_rep VARCHAR(50),    -- Satış temsilcisi adı
    amount DECIMAL(10, 2)     -- Satış tutarı (ondalıklı değer)
);

INSERT INTO sales (id, sales_rep, amount) VALUES
(1, 'John', 500),
(2, 'Jane', 300),
(3, 'John', 700),
(4, 'Jane', 150),
(5, 'John', 200),
(6, 'Alice', 450);

--yalnızca John'un toplam satışlarını toplayıp yazdırın
SELECT sales_rep, SUM (amount) FROM sales
--WHERE sales_rep = 'John'
GROUP BY sales_rep
HAVING sales_rep = 'John';


CREATE TABLE employees ( 
employee_id INT PRIMARY KEY, 
employee_name VARCHAR(100),  
department VARCHAR(50) 
);

INSERT INTO employees (employee_id, employee_name, department) VALUES
(1, 'John', 'Sales'),
(2, 'Jane', 'Marketing'),
(3, 'Alice', 'Sales'),
(4, 'Bob', 'Sales'),
(5, 'Charlie', 'Human Resources'),
(6, 'David', 'Sales'),
(7, 'Eva', 'Marketing'),
(8, 'Frank', 'Sales');

SELECT * FROM employees;

--tüm calısanları calıstıkları departmana gore listeleyiniz

SELECT employee_name, department FROM employees
ORDER BY department;

--tüm calisanlarin calistıkları departmana göre id toplamlarını listeleyiniz !!!
select sum(employee_id),department from employees group by department;--Agretta function --teke indirgeme


CREATE TABLE meslekler
(
id int PRIMARY KEY, 
isim VARCHAR(50), 
soyisin VARCHAR(50), 
meslek CHAR(9), 
maas int
);

INSERT INTO meslekler VALUES (1, 'Ali', 'Can', 'Doktor', '20000' ); 
INSERT INTO meslekler VALUES (2, 'Veli', 'Cem', 'Mühendis', '18000'); 
INSERT INTO meslekler VALUES (3, 'Mine', 'Bulut', 'Doktor', '17008'); 
INSERT INTO meslekler VALUES (4, 'Mahmut', 'Bulut', 'Ögretmen', '15000'); 
INSERT INTO meslekler VALUES (5, 'Mine', 'Yasa', 'Mühendis', '13008'); 
INSERT INTO meslekler VALUES (6, 'Veli', 'Yilmaz', 'Doktor', '12000'); 
INSERT INTO meslekler VALUES (7, 'Ali', 'Can', 'Mühendis', '10000' ); 
INSERT INTO meslekler VALUES (8, 'Veli', 'Cem', 'Ögretmen', '14000');


--Soru-1: meslekler tablosunu isime göre sıralayınız
SELECT * FROM meslekler 
ORDER BY isim;

--Soru-2: meslekler tablosunda maaşı büyükten küçüğe doğru sıralayınız
SELECT * FROM meslekler 
ORDER BY maas DESC;

--Soru-3: meslekler tablosunda ismi Ali olanların maaşıni büyükten küçüğe doğru sıralayınız
SELECT * FROM meslekler 
WHERE isim = 'Ali'
ORDER BY maas DESC;

--Soru-4: meslekler tablosunda id değeri 5 ten büyük olan ilk iki veriyi listeleyiniz

SELECT * FROM meslekler
WHERE id > 5
ORDER BY id
LIMIT 2;

--Soru-5: meslekler tablosunda maaşı en yüksek 3 kişinin bilgilerini getiriniz
SELECT * FROM meslekler
ORDER BY maas DESC
LIMIT 3;

--Soru-6 : meslekler tablosunda meslekleri toplam maaslarina gore listele ve toplam maaslara gore sırala
--1.yol
select meslek,sum(maas)from meslekler group by meslek order by sum(maas);
--2.yol
select meslek,sum(maas) as toplam_maas from meslekler group by meslek order by toplam_maas;

--Soru-7 : meslekler tablosunda meslekleri toplam maas degerleri 30000 ustunde olan meslekleri listele 

select meslek,sum(maas)from meslekler group by meslek having sum(maas)>30000;

--Soru-8 meslekler tablosunda maas degerleri 14000'den buyuk olan degerleri toplayıp mesleklere gore listele
select meslek,sum(maas)from meslekler WHERE maas>14000 GROUP BY meslek;
