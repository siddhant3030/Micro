import React, { Component } from 'react'

export default class PageContent extends Component {
    render() {
        return (
            <div>
                {this.props.children}
            </div>
        )
    }
}
