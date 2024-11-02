--creating table to import data from excel file
create table customer_data (
    customer_id varchar(50) primary key,
    gender varchar(10),
    age integer,
    married varchar(3),
    state varchar(50),
    number_of_referrals integer,
    tenure_in_months integer,
    value_deal varchar(20),
    phone_service varchar(3),
    multiple_lines varchar(3),
    internet_service varchar(3),
    internet_type varchar(20),
    online_security varchar(3),
    online_backup varchar(3),
    device_protection_plan varchar(3),
    premium_support varchar(3),
    streaming_tv varchar(3),
    streaming_movies varchar(3),
    streaming_music varchar(3),
    unlimited_data varchar(3),
    contract varchar(20),
    paperless_billing varchar(3),
    payment_method varchar(50),
    monthly_charge numeric,
    total_charges numeric,
    total_refunds numeric,
    total_extra_data_charges numeric,
    total_long_distance_charges numeric,
    total_revenue numeric,
    customer_status varchar(10),
    churn_category varchar(50),
    churn_reason varchar(255)
);
--checking data from table
select *
from customer_data;
-- analyzing the distribution of distinct values within multiple columns
select gender,
    count(*)::numeric * 100.0 / (
        select count(*)
        from customer_data
    ) as percentage_of_gender
from customer_data
group by gender;
select married,
    count(*)::numeric * 100.0 / (
        select count(*)
        from customer_data
    ) as percentage_of_married
from customer_data
group by married;
select state,
    count(*)::numeric * 100.0 / (
        select count(*)
        from customer_data
    ) as percentage_of_state
from customer_data
group by state
order by percentage_of_state desc;
select customer_status,
    count(*)::numeric * 100.0 / (
        select count(*)
        from customer_data
    ) as percentage_of_status
from customer_data
group by customer_status;
select churn_category,
    count(*)::numeric * 100.0 / (
        select count(*)
        from customer_data
    ) as percentage_of_churn
from customer_data
group by churn_category;
-- counting null entries across all columns
select sum(
        case
            when customer_id is null then 1
            else 0
        end
    ) as null_customer_id_count,
    sum(
        case
            when gender is null then 1
            else 0
        end
    ) as null_gender_count,
    sum(
        case
            when age is null then 1
            else 0
        end
    ) as null_age_count,
    sum(
        case
            when married is null then 1
            else 0
        end
    ) as null_married_count,
    sum(
        case
            when state is null then 1
            else 0
        end
    ) as null_state_count,
    sum(
        case
            when number_of_referrals is null then 1
            else 0
        end
    ) as null_referrals_count,
    sum(
        case
            when tenure_in_months is null then 1
            else 0
        end
    ) as null_tenure_count,
    sum(
        case
            when value_deal is null then 1
            else 0
        end
    ) as null_value_deal_count,
    sum(
        case
            when phone_service is null then 1
            else 0
        end
    ) as null_phone_service_count,
    sum(
        case
            when multiple_lines is null then 1
            else 0
        end
    ) as null_multiple_lines_count,
    sum(
        case
            when internet_service is null then 1
            else 0
        end
    ) as null_internet_service_count,
    sum(
        case
            when internet_type is null then 1
            else 0
        end
    ) as null_internet_type_count,
    sum(
        case
            when online_security is null then 1
            else 0
        end
    ) as null_online_security_count,
    sum(
        case
            when online_backup is null then 1
            else 0
        end
    ) as null_online_backup_count,
    sum(
        case
            when device_protection_plan is null then 1
            else 0
        end
    ) as null_device_protection_count,
    sum(
        case
            when premium_support is null then 1
            else 0
        end
    ) as null_premium_support_count,
    sum(
        case
            when streaming_tv is null then 1
            else 0
        end
    ) as null_streaming_tv_count,
    sum(
        case
            when streaming_movies is null then 1
            else 0
        end
    ) as null_streaming_movies_count,
    sum(
        case
            when streaming_music is null then 1
            else 0
        end
    ) as null_streaming_music_count,
    sum(
        case
            when unlimited_data is null then 1
            else 0
        end
    ) as null_unlimited_data_count,
    sum(
        case
            when contract is null then 1
            else 0
        end
    ) as null_contract_count,
    sum(
        case
            when paperless_billing is null then 1
            else 0
        end
    ) as null_paperless_billing_count,
    sum(
        case
            when payment_method is null then 1
            else 0
        end
    ) as null_payment_method_count,
    sum(
        case
            when monthly_charge is null then 1
            else 0
        end
    ) as null_monthly_charge_count,
    sum(
        case
            when total_charges is null then 1
            else 0
        end
    ) as null_total_charges_count,
    sum(
        case
            when total_refunds is null then 1
            else 0
        end
    ) as null_total_refunds_count,
    sum(
        case
            when total_extra_data_charges is null then 1
            else 0
        end
    ) as null_extra_data_charges_count,
    sum(
        case
            when total_long_distance_charges is null then 1
            else 0
        end
    ) as null_long_distance_charges_count,
    sum(
        case
            when total_revenue is null then 1
            else 0
        end
    ) as null_total_revenue_count,
    sum(
        case
            when customer_status is null then 1
            else 0
        end
    ) as null_customer_status_count,
    sum(
        case
            when churn_category is null then 1
            else 0
        end
    ) as null_churn_category_count,
    sum(
        case
            when churn_reason is null then 1
            else 0
        end
    ) as null_churn_reason_count
from customer_data;
-- creating a new table with updated customer information, replacing nulls with default values
create table updated_customer_data as
select customer_id,
    gender,
    age,
    married,
    state,
    number_of_referrals,
    tenure_in_months,
    coalesce(value_deal, 'none') as filled_value_deal,
    phone_service,
    coalesce(multiple_lines, 'no') as filled_multiple_lines,
    internet_service,
    coalesce(internet_type, 'none') as filled_internet_type,
    coalesce(online_security, 'no') as filled_online_security,
    coalesce(online_backup, 'no') as filled_online_backup,
    coalesce(device_protection_plan, 'no') as filled_device_protection,
    coalesce(premium_support, 'no') as filled_premium_support,
    coalesce(streaming_tv, 'no') as filled_streaming_tv,
    coalesce(streaming_movies, 'no') as filled_streaming_movies,
    coalesce(streaming_music, 'no') as filled_streaming_music,
    coalesce(unlimited_data, 'no') as filled_unlimited_data,
    contract,
    paperless_billing,
    payment_method,
    monthly_charge,
    total_charges,
    total_refunds,
    total_extra_data_charges,
    total_long_distance_charges,
    total_revenue,
    customer_status,
    coalesce(churn_category, 'others') as filled_churn_category,
    coalesce(churn_reason, 'others') as filled_churn_reason
from customer_data;
--checking updated table
select *
from updated_customer_data;
--creating required views for random forest classfier
create view vw_churned as
select *
from updated_customer_data
where customer_status in ('churned', 'stayed');
create view vw_joined as
select *
from updated_customer_data
where customer_status = 'joined';