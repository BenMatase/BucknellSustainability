import React, { Component } from 'react';
import '../../fonts.css'
import {Button, ButtonGroup, Modal, Row, Col, Form, FormGroup, FormControl ,ControlLabel, FormLabel, HelpBlock} from 'react-bootstrap'

export class ClaimDeviceForm extends React.Component {
  constructor(props, context) {
    super(props, context);

    this.handleNameChange = this.handleNameChange.bind(this);
    this.claimDevice = this.claimDevice.bind(this);

    this.state = {
      deviceName: '',
      deviceId: 0
    };
  }

  getNameValidationState() {
    const length = this.state.deviceName.length;
    if (length > 0) return 'success';
    else return 'error'
  }

  handleNameChange(e) {
    this.setState({ deviceName: e.target.value });
  }

  claimDevice() {
    var form_data = new FormData();

    let pairs = ' projectId='+this.props.activeProject.id + ', name="'+this.state.deviceName + '"';
    let cond = ' deviceId='+ this.props.device.deviceId + ' ';

    form_data.append('id_token', this.props.token);
    form_data.append('table', 'device')
    form_data.append('modify_pairs', pairs)
    form_data.append('condition', cond)

    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'http://localhost:5000/update');
    xhr.withCredentials = true;

    xhr.onload = function() {
        //window.location.reload();
    };
    xhr.send(form_data);
  }

  render() {
    return (
    	<div>
        <div className="card-header">
          <h4 className="concert bold card cardTitle"> Device: {this.props.device.hardwareId} </h4> 
          <h5 className="cardSubtitle"> Discovered: {this.props.device.discovered} </h5>
        </div>
        <div className="card-block">

			      <form>
			        <FormGroup
			          controlId="formBasicText"
			          validationState={this.getNameValidationState()}
			        >
			          <h5 className="text-left concert">Name Your Device</h5>
			          <FormControl
			          	className="concert"
			            type="text"
			            value={this.state.deviceName}
			            placeholder="Enter text"
			            onChange={this.handleNameChange}
			          />
			          <FormControl.Feedback />
			          <HelpBlock className="concert">Required</HelpBlock>
			          <Button 
                  className="concert"
                  onClick={() => {this.claimDevice()}}
                  >
                    Claim Device
                </Button>
			        </FormGroup>
			      </form>
        </div>
       </div>

    );
  }
}