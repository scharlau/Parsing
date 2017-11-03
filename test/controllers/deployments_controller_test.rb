require 'test_helper'

class DeploymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @deployment = deployments(:one)
  end

  test "should get index" do
    get deployments_url
    assert_response :success
  end

  test "should get new" do
    get new_deployment_url
    assert_response :success
  end

  test "should create deployment" do
    assert_difference('Deployment.count') do
      post deployments_url, params: { deployment: { Age_class: @deployment.Age_class, BearID: @deployment.BearID, Ear_applied: @deployment.Ear_applied, PTT_ID: @deployment.PTT_ID, Sex: @deployment.Sex, capture_lat: @deployment.capture_lat, capture_long: @deployment.capture_long } }
    end

    assert_redirected_to deployment_url(Deployment.last)
  end

  test "should show deployment" do
    get deployment_url(@deployment)
    assert_response :success
  end

  test "should get edit" do
    get edit_deployment_url(@deployment)
    assert_response :success
  end

  test "should update deployment" do
    patch deployment_url(@deployment), params: { deployment: { Age_class: @deployment.Age_class, BearID: @deployment.BearID, Ear_applied: @deployment.Ear_applied, PTT_ID: @deployment.PTT_ID, Sex: @deployment.Sex, capture_lat: @deployment.capture_lat, capture_long: @deployment.capture_long } }
    assert_redirected_to deployment_url(@deployment)
  end

  test "should destroy deployment" do
    assert_difference('Deployment.count', -1) do
      delete deployment_url(@deployment)
    end

    assert_redirected_to deployments_url
  end
end
