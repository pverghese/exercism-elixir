defmodule LibraryFees do
  def datetime_from_string(string) do
    {_,time}=NaiveDateTime.from_iso8601(string)
    time
  end

  def before_noon?(datetime) do
    t = NaiveDateTime.to_time(datetime)
    if Time.compare(~T[12:00:00], t) ==:gt do
      true
    else
      false
    end

  end

  def return_date(checkout_datetime) do
    if(before_noon?(checkout_datetime)) do
    NaiveDateTime.add(checkout_datetime, 28 * 24 * 60 * 60)
    |> NaiveDateTime.to_date()
    else
    NaiveDateTime.add(checkout_datetime, 29 * 24 * 60 * 60)
    |> NaiveDateTime.to_date()

    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    comp = NaiveDateTime.to_date(actual_return_datetime)
    |>Date.compare(planned_return_date)
    if(comp == :gt) do
      Date.diff(NaiveDateTime.to_date(actual_return_datetime), planned_return_date)
    else
      0
    end
  end

  def monday?(datetime) do
    check_mon = fn x -> x==1 end
    NaiveDateTime.to_date(datetime)
    |> Date.day_of_week()
    |> check_mon.()
  end

  def calculate_late_fee(checkout, return, rate) do
    prd = checkout |> datetime_from_string() |> return_date()
    rd = return |> datetime_from_string()
    if(monday?(rd)) do
      floor days_late(prd, rd) * rate / 2

    else
      days_late(prd, rd) * rate
    end
  end
end
