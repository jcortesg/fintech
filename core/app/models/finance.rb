class Finance
  include Mongoid::Document
  field :activo_liquido, type: Integer
  field :activo_restante, type: Integer
  field :deuda_hipoteca, type: Integer
  field :tarjetas_rativos, type: Integer
  field :creditos, type: Integer
  field :ingresos, type: Integer
  field :pension, type: Integer
  field :otros_ingresos, type: Integer
  field :cuaota_hipotecaria, type: Integer
  field :targetas_credito, type: Integer
  field :otro_creditos, type: Integer
  field :pagos_recurrentes, type: Integer
  field :ahorros, type: Integer
  field :abono_hogar, type: Integer
end
