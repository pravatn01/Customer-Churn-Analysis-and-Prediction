create database db_churn;
use db_churn;
select *
from dbo.customer_data;
-- counting null entries across all columns
select sum(iif(customer_id is null, 1, 0)) as null_customer_id,
    sum(iif(gender is null, 1, 0)) as null_gender,
    sum(iif(age is null, 1, 0)) as null_age,
    sum(iif(relationship_status is null, 1, 0)) as null_relationship_status,
    sum(iif(state is null, 1, 0)) as null_state,
    sum(iif(number_of_referrals is null, 1, 0)) as null_referrals,
    sum(iif(tenure_in_months is null, 1, 0)) as null_tenure,
    sum(iif(value_deal is null, 1, 0)) as null_value_deal,
    sum(iif(voice_assistance is null, 1, 0)) as null_voice_assistance,
    sum(iif(dual_connectivity is null, 1, 0)) as null_dual_connectivity,
    sum(iif(data_service is null, 1, 0)) as null_data_service,
    sum(iif(data_plan is null, 1, 0)) as null_data_plan,
    sum(iif(cyber_protection is null, 1, 0)) as null_cyber_protection,
    sum(iif(data_backup is null, 1, 0)) as null_data_backup,
    sum(iif(gadget_protection is null, 1, 0)) as null_gadget_protection,
    sum(iif(vip_support is null, 1, 0)) as null_vip_support,
    sum(iif(video_streaming is null, 1, 0)) as null_video_streaming,
    sum(iif(cinema_streaming is null, 1, 0)) as null_cinema_streaming,
    sum(iif(audio_streaming is null, 1, 0)) as null_audio_streaming,
    sum(iif(unlimited_data is null, 1, 0)) as null_unlimited_data,
    sum(iif(service_commitment is null, 1, 0)) as null_service_commitment,
    sum(iif(digital_invoicing is null, 1, 0)) as null_digital_invoicing,
    sum(iif(payment_method is null, 1, 0)) as null_payment_method,
    sum(iif(monthly_charge is null, 1, 0)) as null_monthly_charge,
    sum(iif(total_charges is null, 1, 0)) as null_total_charges,
    sum(iif(total_refunds is null, 1, 0)) as null_total_refunds,
    sum(iif(total_extra_data_charges is null, 1, 0)) as null_extra_data_charges,
    sum(iif(total_long_distance_charges is null, 1, 0)) as null_long_distance_charges,
    sum(iif(total_revenue is null, 1, 0)) as null_total_revenue,
    sum(iif(customer_status is null, 1, 0)) as null_customer_status,
    sum(iif(churn_category is null, 1, 0)) as null_churn_category,
    sum(iif(churn_reason is null, 1, 0)) as null_churn_reason
from dbo.customer_data;
-- creating a new table with updated customer information, replacing nulls with default values
select customer_id,
    gender,
    age,
    relationship_status,
    state,
    number_of_referrals,
    tenure_in_months,
    isnull(value_deal, 'None') as value_deal,
    voice_assistance,
    isnull(dual_connectivity, 'No') as dual_connectivity,
    data_service,
    isnull(data_plan, 'None') as data_plan,
    isnull(cyber_protection, 'No') as cyber_protection,
    isnull(data_backup, 'No') as data_backup,
    isnull(gadget_protection, 'No') as gadget_protection,
    isnull(vip_support, 'No') as vip_support,
    isnull(video_streaming, 'No') as video_streaming,
    isnull(cinema_streaming, 'No') as cinema_streaming,
    isnull(audio_streaming, 'No') as audio_streaming,
    isnull(unlimited_data, 'No') as unlimited_data,
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
    isnull(churn_category, 'Others') as churn_category,
    isnull(churn_reason, 'Others') as churn_reason into dbo.cleaned_customer_data
from dbo.customer_data;
--checking distribution of distinct values in columns
select gender,
    count(*) * 100.0 / (
        select count(*)
        from dbo.cleaned_customer_data
    ) as gender_percentage
from dbo.cleaned_customer_data
group by gender;
select relationship_status,
    count(*) * 100.0 / (
        select count(*)
        from dbo.cleaned_customer_data
    ) as relationship_percentage
from dbo.cleaned_customer_data
group by relationship_status;
select state,
    count(*) * 100.0 / (
        select count(*)
        from dbo.cleaned_customer_data
    ) as state_percentage
from dbo.cleaned_customer_data
group by state
order by state_percentage desc;
select customer_status,
    count(*) * 100.0 / (
        select count(*)
        from dbo.cleaned_customer_data
    ) as status_percentage
from dbo.cleaned_customer_data
group by customer_status;
select churn_category,
    count(*) * 100.0 / (
        select count(*)
        from dbo.cleaned_customer_data
    ) as churn_category_percentage
from dbo.cleaned_customer_data
group by churn_category;
--creating views
create view vw_churndata as
select *
from dbo.cleaned_customer_data
where customer_status in ('Churned', 'Stayed');
create view vw_joindata as
select *
from dbo.cleaned_customer_data
where customer_status = 'Joined';
--checking views
select *
from vw_churndata;
select *
from vw_joindata;