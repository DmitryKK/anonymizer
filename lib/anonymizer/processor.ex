defprotocol Anonymizer.Processor do
  @moduledoc """
    Модуль реализует обработку переданных данных по указанному пути и типу преобразования
  """

  def process(data, path, type)
end
