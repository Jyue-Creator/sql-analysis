# Chinook音樂商店數據分析報告

**分析師：** Jyue 
**分析日期：** 2026-02-17  
**資料來源：** Chinook Database (SQLite sample database)  
**資料期間：** 2009-2013  

---

## 📋 摘要

本報告分析Chinook音樂商店的客戶、銷售、員工績效等數據，
發現USA是最大市場，Rock音樂最暢銷，但2013年營收出現下滑。

---

## 🔍 分析問題與發現

### 1️⃣ 客戶地理分布分析

**問題：** 哪個國家的客戶最多？

**SQL查詢：**
```sql
select country, count(*) as customer_number
FROM customers
group by Country
order by customer_number desc
limit 5

| Country | CustomerCount |
|---------|---------------|
| USA     | 13            |
| Canada  | 8             |
| France  | 5             |
| Brazil  | 5             |
| Germany | 4             |


**分析發現：**
- USA是最大市場，擁有13位客戶（佔總客戶22%）
- 北美地區合計21位客戶，是主要市場
- 歐洲市場分散但總量也不小

**商業建議：**
- 加強USA市場的客戶忠誠度計畫
- 考慮在加拿大開設分站
- 歐洲市場需要本地化策略

---
  
### 2️⃣ 音樂類型銷售分析

**問題：** 哪種音樂類型最暢銷？

**SQL查詢：**
```sql

select genres.name,  
  sum(invoice_items.UnitPrice*invoice_items.Quantity) as sales, 
  round(sum(invoice_items.UnitPrice*invoice_items.Quantity)*100.0/(SELECT sum(UnitPrice*Quantity) from invoice_items),2) as percentage
FROM genres
inner join tracks on tracks.GenreId = genres.GenreId
inner join invoice_items on tracks.TrackId = invoice_items.TrackId
group by genres.name
order by sales desc
LIMIT 5

| Genre              | Sales  | Percentage |
| :----------------- | :----: | :--------: |
| Rock               | 826.65 |    35.5    |
| Latin              | 382.14 |   16.41    |
| Metal              | 261.36 |   11.22    |
| Alternative & Punk | 241.56 |   10.37    |
| TV Shows           | 93.53  |    4.02    |

**分析發現：**
1. **Rock音樂獨占鰲頭**
   - 營收$826.65，是第二名Latin的2.16倍
   - 佔前5名總營收45.8%

2. **營收集中度高**
   - 前3名（Rock, Latin, Metal）佔前5名總營收81.5%
   - 產品組合過度依賴特定類型

3. **長尾效應明顯**
   - TV Shows營收僅$93.53
   - Rock營收是其8.8倍

**商業洞察：**
- Rock音樂是現金牛，需要持續投資維護
- Latin音樂有潛力，可加強推廣
- 考慮開發新興音樂類型分散風險
- Alternative & Punk與Metal營收接近，可聯合行銷

**風險提示：**
⚠️ 過度依賴Rock音樂，若該類型市場萎縮將嚴重影響營收


---

### 3️⃣ 營收趨勢分析

**問題：** 每月銷售額趨勢如何？

**SQL查詢：**
```sql
SELECT Strftime('%Y-%m', InvoiceDate) as Month,
Sum(total) as Revenue,
Count(*) as Ordercount
from invoices
GROUP by month
Order by month

|  Month  | Revenue | OrderCount |
| :-----: | :-----: | :--------: |
| 2009-01 |  35.64  |     6      |
| 2009-02 |  37.62  |     7      |
| 2009-03 |  37.62  |     7      |
| 2009-04 |  37.62  |     7      |
| 2009-05 |  37.62  |     7      |
| 2009-06 |  37.62  |     7      |
| 2009-07 |  37.62  |     7      |
| 2009-08 |  37.62  |     7      |
| 2009-09 |  37.62  |     7      |
| 2009-10 |  37.62  |     7      |
| 2009-11 |  37.62  |     7      |
| 2009-12 |  37.62  |     7      |
| 2010-01 |  52.62  |     7      |
| 2010-02 |  46.62  |     7      |
| 2010-03 |  44.62  |     7      |
| 2010-04 |  37.62  |     7      |
| 2010-05 |  37.62  |     7      |
| 2010-06 |  37.62  |     7      |
| 2010-07 |  37.62  |     7      |
| 2010-08 |  37.62  |     7      |
| 2010-09 |  36.63  |     6      |
| 2010-10 |  37.62  |     7      |
| 2010-11 |  37.62  |     7      |
| 2010-12 |  37.62  |     7      |
| 2011-01 |  37.62  |     7      |
| 2011-02 |  37.62  |     7      |
| 2011-03 |  37.62  |     7      |
| 2011-04 |  51.62  |     7      |
| 2011-05 |  42.62  |     7      |
| 2011-06 |  50.62  |     7      |
| 2011-07 |  37.62  |     7      |
| 2011-08 |  37.62  |     7      |
| 2011-09 |  37.62  |     7      |
| 2011-10 |  37.62  |     7      |
| 2011-11 |  23.76  |     6      |
| 2011-12 |  37.62  |     7      |
| 2012-01 |  37.62  |     7      |
| 2012-02 |  37.62  |     7      |
| 2012-03 |  37.62  |     7      |
| 2012-04 |  37.62  |     7      |
| 2012-05 |  37.62  |     7      |
| 2012-06 |  37.62  |     7      |
| 2012-07 |  39.62  |     7      |
| 2012-08 |  47.62  |     7      |
| 2012-09 |  46.71  |     6      |
| 2012-10 |  42.62  |     7      |
| 2012-11 |  37.62  |     7      |
| 2012-12 |  37.62  |     7      |
| 2013-01 |  37.62  |     7      |
| 2013-02 |  27.72  |     5      |
| 2013-03 |  37.62  |     7      |
| 2013-04 |  33.66  |     5      |
| 2013-05 |  37.62  |     7      |
| 2013-06 |  37.62  |     7      |
| 2013-07 |  37.62  |     7      |
| 2013-08 |  37.62  |     7      |
| 2013-09 |  37.62  |     7      |
| 2013-10 |  37.62  |     7      |
| 2013-11 |  49.62  |     7      |
| 2013-12 |  38.62  |     7      |


**視覺化說明：**
（在實際工作中會畫圖表，現在用文字描述）
- 2009-2010 年： 營收從低點穩定爬升，並在 2010 年 1 月 達到初期最高峰（$52.62）。
- 2011-2012 年： 進入平穩期，營收多維持在 $37-47 之間，但在 2011 年 11 月 出現了異常低點（$23.76）。
- 2013 年： 表現極不穩定，2 月與 4 月 出現明顯下滑（$27-33），雖然 11 月強勢反彈，但整體波動幅度為歷年最大。

**分析發現：**
- 月均營收約$37-40
- 沒有明顯季節性波動
- 2013年出現營收下滑警訊


### 4️⃣ 高價值客戶分析

**問題：** 誰是最有價值的客戶？

**SQL查詢：**
```sql
SELECT customers.CustomerId, customers.FirstName, customers.LastName,
 Sum(invoices.total) as TotalSpent,
 Count(invoices.InvoiceId) as OrderCount,
 Round(avg(invoices.total),2) as AvgOrderValue
 from customers
 Inner join invoices
  On invoices.CustomerId = customers.CustomerId
  GROUP by customers.CustomerId
  ORDER By totalspent desc
  LIMIT 10

| Rank | CustomerName      | Country        | TotalSpent | OrderCount | AvgOrderValue |
| :--: | :---------------: | :------------: | :--------: | :--------: | :-----------: |
|  1   | Helena Holý       | Czech Republic |   49.62    |     7      |     7.09      |
|  2   | Richard Cunningham| USA            |   47.62    |     7      |     6.80      |
|  3   | Luis Rojas        | Chile          |   46.62    |     7      |     6.66      |
|  4   | Ladislav Kovács   | Hungary        |   45.62    |     7      |     6.52      |
|  5   | Hugh O'Reilly     | Ireland        |   45.62    |     7      |     6.52      |
|  6   | Frank Ralston     | USA            |   43.62    |     7      |     6.23      |
|  7   | Julia Barnett     | USA            |   43.62    |     7      |     6.23      |
|  8   | Fynn Zimmermann   | Germany        |   43.62    |     7      |     6.23      |
|  9   | Astrid Gruber     | Austria        |   42.62    |     7      |     6.09      |
|  10  | Victor Stevens    | USA            |   42.62    |     7      |     6.09      |

**分析發現：**
- Top 10 客戶消費$42-50
- Top 10 平均訂單金額$6-7
- 高價值客戶來自多國，非集中在USA

**商業建議：**
- 建立VIP會員制度
- 針對高價值客戶推送個人化推薦
- 分析流失風險

---

### 5️⃣ 員工績效分析

**問題：** 員工銷售表現如何？

**SQL查詢：**
SELECT employees.EmployeeId, employees.FirstName, employees.LastName, 
SUM(invoices.total)as TotalSales, 
count(DISTINCT customers.CustomerId)as CustomersServed
 FROM employees
 INNER JOIN customers on employees.EmployeeId = customers.SupportRepId
 INNER JOIN invoices on customers.CustomerId = invoices.CustomerId
 GROUP by employees.EmployeeId 
 ORDER by totalsales DESC
 
 **查詢結果：**
| EmployeeId | EmployeeName     | TotalSales | CustomersServed |
| :--------: | :--------------: | :--------: | :-------------: |
|     3      | Jane Peacock     |   833.04   |       21        |
|     4      | Margaret Park    |   775.40   |       20        |
|     5      | Steve Johnson    |   720.16   |       18        |


**分析發現：**
- Jane Peacock是銷售冠軍
- Steve Johnson 的平均客戶貢獻價值最高
- 人均服務18-21位客戶

---
  


  
