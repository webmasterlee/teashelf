require 'test_helper'

class AttsControllerTest < ActionController::TestCase
  setup do
    @att = atts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:atts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create att" do
    assert_difference('Att.count') do
      post :create, att: { name: @att.name, user_id: @att.user_id }
    end

    assert_redirected_to att_path(assigns(:att))
  end

  test "should show att" do
    get :show, id: @att
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @att
    assert_response :success
  end

  test "should update att" do
    patch :update, id: @att, att: { name: @att.name, user_id: @att.user_id }
    assert_redirected_to att_path(assigns(:att))
  end

  test "should destroy att" do
    assert_difference('Att.count', -1) do
      delete :destroy, id: @att
    end

    assert_redirected_to atts_path
  end
end
