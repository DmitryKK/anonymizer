defimpl Anonymizer.Processor, for: Map do
  @moduledoc "Реализация протокола Anonymizer.Processor для типа данных Map"

  alias Anonymizer.Mask

  @doc "Функция для маскировки строки по указанному пути"
  @spec process(map(), String.t(), :mask) :: map()
  def process(data, path, :mask) when is_binary(path) do
    {_, new_data} = get_and_update_in(data, keys(path), &{&1, Mask.run(&1)})
    new_data
  end

  @doc "Функция для удаления структуры по указанному пути"
  @spec process(map(), String.t(), :drop) :: map()
  def process(data, path, :drop) when is_binary(path) do
    {_, new_data} = pop_in(data, keys(path))
    new_data
  end

  def process(data, _, _), do: data

  defp keys(path), do: for(key <- String.split(path, "/"), do: String.to_atom(key))
end
