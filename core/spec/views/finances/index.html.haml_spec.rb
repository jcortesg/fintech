require 'spec_helper'

describe "finances/index" do
  before(:each) do
    assign(:finances, [
      stub_model(Finance,
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
      ),
      stub_model(Finance,
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
      )
    ])
  end

  it "renders a list of finances" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => 10.to_s, :count => 2
    assert_select "tr>td", :text => 11.to_s, :count => 2
    assert_select "tr>td", :text => 12.to_s, :count => 2
    assert_select "tr>td", :text => 13.to_s, :count => 2
    assert_select "tr>td", :text => 14.to_s, :count => 2
  end
end
