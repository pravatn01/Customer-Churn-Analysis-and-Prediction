create database db_churn

use db_churn

select * from customer_data

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
            when relationship_status is null then 1
            else 0
        end
    ) as null_relationship_status_count,
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
            when voice_assistance is null then 1
            else 0
        end
    ) as null_voice_assistance_count,
    sum(
        case
            when dual_connectivity is null then 1
            else 0
        end
    ) as null_dual_connectivity_count,
    sum(
        case
            when data_service is null then 1
            else 0
        end
    ) as null_data_service_count,
    sum(
        case
            when data_plan is null then 1
            else 0
        end
    ) as null_data_plan_count,
    sum(
        case
            when cyber_protection is null then 1
            else 0
        end
    ) as null_cyber_protection_count,
    sum(
        case
            when data_backup is null then 1
            else 0
        end
    ) as null_data_backup_count,
    sum(
        case
            when gadget_protection is null then 1
            else 0
        end
    ) as null_gadget_protection_count,
    sum(
        case
            when vip_support is null then 1
            else 0
        end
    ) as null_vip_support_count,
    sum(
        case
            when video_streaming is null then 1
            else 0
        end
    ) as null_video_streaming_count,
    sum(
        case
            when cinema_streaming is null then 1
            else 0
        end
    ) as null_cinema_streaming_count,
    sum(
        case
            when audio_streaming is null then 1
            else 0
        end
    ) as null_audio_streaming_count,
    sum(
        case
            when unlimited_data is null then 1
            else 0
        end
    ) as null_unlimited_data_count,
    sum(
        case
            when service_commitment is null then 1
            else 0
        end
    ) as null_service_commitment_count,
    sum(
        case
            when digital_invoicing is null then 1
            else 0
        end
    ) as null_digital_invoicing_count,
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
SELECT 
    customer_id,
    gender,
    age,
    relationship_status,
    state,
    number_of_referrals,
    tenure_in_months,
    ISNULL(value_deal, 'None') AS value_deal,
    voice_assistance,
    ISNULL(dual_connectivity, 'No') AS dual_connectivity,
    data_service,
    ISNULL(data_plan, 'None') AS data_plan,
    ISNULL(cyber_protection, 'No') AS cyber_protection,
    ISNULL(data_backup, 'No') AS data_backup,
    ISNULL(gadget_protection, 'No') AS gadget_protection,
    ISNULL(vip_support, 'No') AS vip_support,
    ISNULL(video_streaming, 'No') AS video_streaming,
    ISNULL(cinema_streaming, 'No') AS cinema_streaming,
    ISNULL(audio_streaming, 'No') AS audio_streaming,
    ISNULL(unlimited_data, 'No') AS unlimited_data,
    service_commitment,
    digital_invoicing,
    payment_method,
    monthly_charge,
    total_charges,
    total_refunds,
    total_extra_data_charges,
    total_long_distance_charges,
    total_revenue,
    customer_status,
    ISNULL(churn_category, 'Others') AS churn_category,
    ISNULL(churn_reason, 'Others') AS churn_reason

INTO [db_churn].[dbo].[cleaned_customer_data]

FROM [db_churn].[dbo].[customer_data];

--checking distribution of distinct values in columns
select 
    gender,
    count(*) * 100.0 / (
        select count(*)
        from cleaned_customer_data
    ) as percentage_of_gender
from cleaned_customer_data
group by gender;

select 
    relationship_status as married,
    count(*) * 100.0 / (
        select count(*)
        from cleaned_customer_data
    ) as percentage_of_married
from cleaned_customer_data
group by relationship_status;

select 
    state,
    count(*) * 100.0 / (
        select count(*)
        from cleaned_customer_data
    ) as percentage_of_state
from cleaned_customer_data
group by state
order by percentage_of_state desc;

select 
    customer_status,
    count(*) * 100.0 / (
        select count(*)
        from cleaned_customer_data
    ) as percentage_of_status
from cleaned_customer_data
group by customer_status;

select 
    churn_category,
    count(*) * 100.0 / (
        select count(*)
        from cleaned_customer_data
    ) as percentage_of_churn
from cleaned_customer_data
group by churn_category;

--creating views
create view vw_ChurnData as
	select * from cleaned_customer_data 
	where customer_status in ('Churned', 'Stayed');

create view vw_JoinData as
	select * from cleaned_customer_data 
	where customer_status = 'Joined'

--checking views
select * from vw_ChurnData	
select * from vw_JoinData