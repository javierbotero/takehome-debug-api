# README

The solution to the problem is adding a counter_cache in the `Hit` model and the proper column in the `User` model, resetting it to 0 through a cron job at the beginning of each month based on the time zones the apps wants to register.

## counter_cache

Rails provides the built in [counter_cache](https://guides.rubyonrails.org/association_basics.html#options-for-has-many-counter-cache) feature in the has_many and associations where each time a new record is created in the child model, the counter_cache column in the parent model is incremented. This is useful for keeping track of the number of records in a table, saving the time to make a new query per request to the database to get the number of records.

## Cron Jobs

To run the cron jobs, we need to install the [whenever](https://github.com/javan/whenever) gem. This gem allows us to schedule cron jobs in the ```config/schedule.rb``` file. Here we will reset the counter_cache column in the ```User``` model to 0 at the beginning of each month per time zone register or used in the app. Each cron job will be trigger between the 28-31 day per month and the first day for time zones which have a positive offset. When the cron job runs it will trigger the `User.reset_monthly_hits!` which will verify the offset. If the offset is  a negative number it will check if it is the last day of the month for the current time zone, if it is not the case will return an avoid any action. If it is the last day of the month it will proceed. Each cron job will be call at the proper offset time zone from UTC.

To register a user:

path: ```/users/register```
params: ```{ email: 'jhondoe@mail.com', timezone: 'Australia/Sydney' }```

To install the cron jobs where the API is running:

```
$ whenever --update-crontab
```