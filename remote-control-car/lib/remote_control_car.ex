defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, distance_driven_in_meters: 0, battery_percentage: 100]


  def new(nickname \\ "none") do
    # Please implement the new/1 function
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(%RemoteControlCar{distance_driven_in_meters: d}) do
    Integer.to_string(d) <> " meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: 0}), do: "Battery empty"
  def display_battery(%RemoteControlCar{battery_percentage: b}) do
    # Please implement the display_battery/1 function
    "Battery at #{b}%"
  end

  def drive(remote_car = %RemoteControlCar{battery_percentage: 0}), do: remote_car
  def drive(remote_car = %RemoteControlCar{battery_percentage: b, distance_driven_in_meters: d}) do
    # Please implement the drive/1 function
    %{remote_car | battery_percentage: b-1, distance_driven_in_meters: d+20}
  end
end
