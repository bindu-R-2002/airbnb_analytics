select
    date_trunc('month', date) as review_month,
    count(*) as total_reviews
from {{ ref('fct_reviews') }}
group by 1
order by 1