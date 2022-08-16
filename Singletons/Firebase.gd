extends Node

const API_KEY := "AIzaSyDp_KflUJM026VY3ZsptVp-wdeb0-z7Tgw"

const REGISTER_URL := "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=%s" % API_KEY
const LOGIN_URL := "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=%s" % API_KEY
const ANONYMOUS_URL := "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=%s" % API_KEY

var current_token := ""
var current_refresh_token := ""
var user_id := ""

signal got_token(token, refresh, uid)

func _get_result_body(result: Array) -> Dictionary:
	var result_body : Dictionary= JSON.parse(result[3].get_string_from_ascii()).result as Dictionary
	return result_body


func anonymous_sign(http: HTTPRequest) -> void:
	var body := {
		"returnSecureToken": true
	}
	
	http.request(ANONYMOUS_URL, [], false, HTTPClient.METHOD_POST, to_json(body))
	var result := yield(http, "request_completed") as Array
	if result[1] == 200:
		var result_body = _get_result_body(result)
		current_token = result_body.idToken
		current_refresh_token = result_body.refreshToken
		user_id = result_body.localId
	emit_signal("got_token", current_token, current_refresh_token, user_id)


func register(email: String, password: String, http: HTTPRequest) -> void:
	var body := {
		"email": email,
		"password": password
	}
	
	http.request(REGISTER_URL, [], false, HTTPClient.METHOD_POST,to_json(body))
	var result := yield(http, "request_completed") as Array
	if result[1] == 200:
		var result_body = _get_result_body(result)
		current_token = result_body.idToken
		current_refresh_token = result_body.refreshToken
		user_id = result_body.localId
	emit_signal("got_token", current_token, current_refresh_token, user_id)


func login(email: String, password: String, http: HTTPRequest) -> void:
	var body := {
		"email": email,
		"password": password
	}
	
	http.request(LOGIN_URL, [], false, HTTPClient.METHOD_POST,to_json(body))
	var result := yield(http, "request_completed") as Array
	if result[1] == 200:
		var result_body = _get_result_body(result)
		current_token = result_body.idToken
		user_id = result_body.localId
	emit_signal("got_token", current_token, current_refresh_token, user_id)

