require 'spec_helper'

describe "finances/edit" do
  before(:each) do
    @finance = assign(:finance, stub_model(Finance,
      :activo_liquido => 1,
      :activo_restante => 1,
      :deuda_hipoteca => 1,
      :tarjetas_rativos => 1,
      :creditos => 1,
      :ingresos => 1,
      :pension => 1,
      :otros_ingresos => 1,
      :cuaota_hipotecaria => 1,
      :targetas_credito => 1,
      :otro_creditos => 1,
      :pagos_recurrentes => 1,
      :ahorros => 1,
      :abono_hogar => 1
    ))
  end

  it "renders the edit finance form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", finance_path(@finance), "post" do
      assert_select "input#finance_activo_liquido[name=?]", "finance[activo_liquido]"
      assert_select "input#finance_activo_restante[name=?]", "finance[activo_restante]"
      assert_select "input#finance_deuda_hipoteca[name=?]", "finance[deuda_hipoteca]"
      assert_select "input#finance_tarjetas_rativos[name=?]", "finance[tarjetas_rativos]"
      assert_select "input#finance_creditos[name=?]", "finance[creditos]"
      assert_select "input#finance_ingresos[name=?]", "finance[ingresos]"
      assert_select "input#finance_pension[name=?]", "finance[pension]"
      assert_select "input#finance_otros_ingresos[name=?]", "finance[otros_ingresos]"
      assert_select "input#finance_cuaota_hipotecaria[name=?]", "finance[cuaota_hipotecaria]"
      assert_select "input#finance_targetas_credito[name=?]", "finance[targetas_credito]"
      assert_select "input#finance_otro_creditos[name=?]", "finance[otro_creditos]"
      assert_select "input#finance_pagos_recurrentes[name=?]", "finance[pagos_recurrentes]"
      assert_select "input#finance_ahorros[name=?]", "finance[ahorros]"
      assert_select "input#finance_abono_hogar[name=?]", "finance[abono_hogar]"
    end
  end
end
