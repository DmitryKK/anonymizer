defmodule Anonymizer do
  @moduledoc "Модуль для анонимизации данных"

  alias Anonymizer.Processor

  @doc "Функция реализует анонимизацию переданной структуры по указанному шаблону"
  @spec anonymize(any(), map()) :: {:ok, any()} | {:error, any()}
  def anonymize(data, profile) do
    result =
      Enum.reduce(profile, data, fn {path, type}, new_data ->
        Processor.process(new_data, path, type)
      end)

    {:ok, result}
  rescue
    error -> {:error, error}
  end
end
