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
