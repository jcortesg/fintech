require 'spec_helper'

describe "finances/show" do
  before(:each) do
    @finance = assign(:finance, stub_model(Finance,
      :activo_liquido => 1,
      :activo_restante => 2,
      :deuda_hipoteca => 3,
      :tarjetas_rativos => 4,
      :creditos => 5,
      :ingresos => 6,
      :pension => 7,
      :otros_ingresos => 8,
      :cuaota_hipotecaria => 9,
      :targetas_credito => 10,
      :otro_creditos => 11,
      :pagos_recurrentes => 12,
      :ahorros => 13,
      :abono_hogar => 14
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/6/)
    rendered.should match(/7/)
    rendered.should match(/8/)
    rendered.should match(/9/)
    rendered.should match(/10/)
    rendered.should match(/11/)
    rendered.should match(/12/)
    rendered.should match(/13/)
    rendered.should match(/14/)
  end
end
