with credit_count as (
select customer_id,
	   sum(credit_amount) as total_to_be_paid
from credit
group by customer_id 
)
select 
	s.sale_id,
	c.customer_id ,
	sp.sale_person_id,
	c.full_name as "Customer Full Nmae",
	s.amount as "Sales Amount",
	c.phone_number as "Customer Phone Number",
	p."name" as "Product Name",
	p.serial_number as "Product Serial Number",
	sp.full_name as "Sales Person Full Names",
	sp.phone_number as "Sales person Phone Number",
	sp.bash_number as "Sales Person Bash Number",
	t.country as "Sales Country",
	t.city  as "Sales City",
	case
		when cc.total_to_be_paid > 0
			then cc.total_to_be_paid
		when cc.total_to_be_paid is null
			then 0
	end as total_to_be_paid,
	s.order_date,
	s.approved_at 
from sales s 
left join customers c
	on s.customer_id = c.customer_id
left join sales_person sp 
	on s.sales_person_id = sp.sale_person_id 
left join products p 
	on s.product_id = p.product_id
left join public.territory t 
	on t.territory_id = s.sale_territory_id 
left join credit_count cc
   on c.customer_id = cc.customer_id