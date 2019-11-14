defmodule AnonymizerTest do
  use ExUnit.Case

  setup do
    data = %{
      customer: %{
        name: "Andrew",
        surname: "Yudin",
        email: "andrew@channex.io"
      },
      checkin_date: "2019-02-20",
      checkout_date: "2019-02-21"
    }

    profile = [
      {"customer/name", :mask},
      {"customer/surname", :mask},
      {"customer/email", :drop}
    ]

    {:ok, data: data, profile: profile}
  end

  test "performs anonymization with correct profile", %{profile: profile, data: data} do
    {:ok, new_data} = Anonymizer.anonymize(data, profile)

    refute new_data[:customer][:email]
    refute new_data[:customer][:name] == data[:customer][:name]
    refute new_data[:customer][:surname] == data[:customer][:surname]
  end

  test "performs anonymization with empty profile", %{data: data} do
    assert {:ok, data} == Anonymizer.anonymize(data, [])
  end

  test "does not perform anonymization with incorrect profile", %{data: data} do
    profile = [{"a/b/c", :mask}]

    {:error, _} = Anonymizer.anonymize(data, profile)
  end
end
