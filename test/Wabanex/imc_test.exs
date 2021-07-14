defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true
  alias Wabanex.IMC

  describe "calculate/1" do
    test "when the file exists, returns the data" do
      params = %{"filename" => "students.csv"}

      response = IMC.calculate(params)

      expected_response =
        {:ok,
         %{
           "Dani" => 18.75,
           "Diego" => 20.50561797752809,
           "Gabul" => 20.0,
           "Gustavo" => 22.285714285714285,
           "Rodrigo" => 23.61111111111111
         }}

      assert expected_response == response
    end

    test "when the wrong filename is given, returns an error" do
      params = %{"filename" => "banana.csv"}

      response = IMC.calculate(params)

      expected_response = {:error, "Error while opening the file"}

      assert expected_response == response
    end
  end
end
