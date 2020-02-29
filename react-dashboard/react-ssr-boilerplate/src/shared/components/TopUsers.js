import React, { Component } from 'react'

export default class TopUsers extends Component {
     constructor(){
        super();
        this.state = {
            users :"",
            
        }
    }

     componentDidMount(){
        console.log("top users",this.props.topUsers);
        this.setState({users:this.props.topUsers})
    }

    render() {
        console.log("top  users",this.state.users)
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
                    this.state.users.map((user,index)=>{
                        console.log("user", user)
                        return(
                            <tr>
                                <th scope="row">{user.id}</th>
                                <td>{user.name}</td>
                                <td>{user.email}</td>
                                <td><input type="checkbox" onClick={()=>this.handleClick(user.id,index)}/></td>
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
