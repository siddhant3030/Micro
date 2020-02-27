import React, { Component } from 'react'
import Axios from 'axios';

export default class Users extends Component {
    constructor(){
        super();
        this.state = {
            users :[]
        }
    }

    async componentDidMount(){
        const data = await Axios.get('https://jsonplaceholder.typicode.com/users');
        console.log("users", data.data)
        this.setState({users:data.data})
    }

    render() {
        return (
            <div>
            {this.state.users.length>0 &&<table class="table">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Name</th>
      <th scope="col">Email</th>
    </tr>
  </thead>
  <tbody>
                {
                    this.state.users.map((user)=>{
                        console.log("user", user)
                        return(
                            <tr>
                                <th scope="row">{user.id}</th>
                                <td>{user.name}</td>
                                <td>{user.email}</td>
                            </tr>
                        )
                    })
                }

                </tbody>
                </table>}
            </div>
        )
    }
}
