import React, { Component } from 'react'
import Axios from 'axios';
// import "./users.css"



export default class Users extends Component {
    constructor(){
        super();
        this.state = {
            users :[],
            topUser:[]
        }
    }

    async componentDidMount(){
        const data = await Axios.get('https://jsonplaceholder.typicode.com/users');
        console.log("users", data.data)
        this.setState({users:data.data})
    }

handleClick =(id,index)=>{
    const {getTopUsers} = this.props;
    const found = this.state.users.find(element => element.id == id);
    const sliced= this.state.users.slice(index, id);
    this.state.topUser.push(sliced[0]);
    
    
//    const newTopUser= {...this.state.topUser,...sliced[0]};
//    console.log("new user",this.state.topUser,)


    // this.state.users.splice(index,1); [if we don't want the same user in user navigation]
    
    this.setState({})
    getTopUsers(this.state.topUser);

   
}
    render() {
        return (
            <div>
            {this.state.users.length>0 &&<table class="table">
  <thead>
    <tr>
      <th scope="col"></th>
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
                                <td><input type="checkbox" onClick={()=>this.handleClick(user.id,index)}/></td>
                                <th scope="row">{user.id}</th>
                                <td>{user.name}</td>
                                <td>{user.email}</td>

                                <td>
                                    <label class="switch">
                                    <input type="checkbox"/>
                                    <span class="slider round"></span>
                                    </label>
                                </td>

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
