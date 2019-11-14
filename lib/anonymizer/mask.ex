defmodule Anonymizer.Mask do
  @moduledoc """
    Модуль реализует маскировку символов строки
  """

  @mask_chars ~w(& * ! @ # $ % ~ $)

  @doc "Функция реализует маскировку переданной строки"
  @spec run(String.t()) :: String.t()
  def run(str) when is_binary(str) do
    case String.length(str) do
      length when length <= 2 -> random_mask_string(length)
      length -> String.first(str) <> random_mask_string(length - 2) <> String.last(str)
    end
  end

  def run(str), do: str

  defp random_mask_string(length) do
    for _ <- 1..length, into: "", do: Enum.random(@mask_chars)
  end
end
