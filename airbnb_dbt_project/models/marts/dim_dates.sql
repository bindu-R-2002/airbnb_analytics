with date_bounds as (

    select
        min(date) as min_date,
        current_date() as max_date
    from {{ ref('stg_reviews') }}

),

date_spine as (

    select
        dateadd(day, seq4(), min_date) as date_day
    from date_bounds,
         table(generator(rowcount => 10000))

),

final as (

    select
        date_day,
        year(date_day) as year,
        quarter(date_day) as quarter,
        month(date_day) as month,
        monthname(date_day) as month_name,
        day(date_day) as day_of_month,
        dayofweek(date_day) as day_of_week,
        dayname(date_day) as day_name,
        weekofyear(date_day) as week_of_year,
        case
            when dayofweek(date_day) in (0, 6) then true
            else false
        end as is_weekend
    from date_spine
    where date_day <= current_date()

)

select *
from final