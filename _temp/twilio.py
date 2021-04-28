from twilio.rest import Client

# Send Whatsapp Msg with twilio


def send_whatsapp_msg(body):
    account_sid = 'AC221b3b1e88f0525b3157fb16ce06cf57'
    auth_token = 'b17f699d9c9bb57c378fb9a249f3ac32'
    try:
        client = Client(account_sid, auth_token)
        for phone_number in phone_numbers:
            client.messages.create(
                from_='whatsapp:+14155238886',
                body=f'{body}',
                to=f'whatsapp:{phone_number[0]}'
            )
    except:
        write_run_log("Error : Cannot send twilio message")
