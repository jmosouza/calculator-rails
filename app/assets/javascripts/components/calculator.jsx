class Calculator extends React.Component {
  constructor(props) {
    super(props)

    this.onSubmit = this.onSubmit.bind(this)
    this.onChangeInput = this.onChangeInput.bind(this)

    this.state = {
      left_input: 0,
      right_input: 0
    }
  }

  onSubmit (event) {
    event.preventDefault()

    const fetchOptions = {
      method: 'post',
      headers: {
        'Accept': 'text/plain',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        operation: event.target.value,
        left_input: this.state.left_input,
        right_input: this.state.right_input
      })
    }

    fetch('/calculations', fetchOptions)
      .then(data => data.text())
      .then(text => {
        this.setState({
          detailed_result: text,
          simple_result: text === 'error\n'
            ? '💥'
            : text.split('\n')[1].split(' ')[1]
        })
      })
  }

  onChangeInput (event) {
    this.setState({
      [event.target.name]: event.target.value
    })
  }

  render () {
    const {
      left_input,
      right_input,
      simple_result,
      detailed_result,
    } = this.state

    const isInputValid =
      left_input >= 0 &&
      left_input < 100 &&
      right_input >= 0 &&
      right_input < 100

    const operations = [
      {
        symbol: '+',
        name: 'sum_op'
      },
      {
        symbol: '-',
        name: 'difference_op'
      },
      {
        symbol: '×',
        name: 'multiplication_op'
      },
      {
        symbol: '÷',
        name: 'division_op'
      }
    ]

    return (
      <div>
        <div>
          <div>
            {this.renderInput('left_input', left_input)}
          </div>
          <div>
            {operations.map(operation =>
              this.renderButton(operation, isInputValid)
            )}
          </div>
          <div>
            {this.renderInput('right_input', right_input)}
          </div>
        </div>
        <div>
          =
        </div>
        <div>
          {simple_result}
        </div>
        <div>
          <textarea
            rows='4'
            disabled='true'
            value={detailed_result}
          />
        </div>
      </div>
    )
  }

  renderInput (name, value) {
    return (
      <input
        type='number'
        name={name}
        value={value}
        onChange={this.onChangeInput}
      />
    )
  }

  renderButton (operation, isInputValid) {
    return (
      <button
        key={operation.name}
        name='operation'
        value={operation.name}
        disabled={!isInputValid}
        onClick={this.onSubmit}
      >
        {operation.symbol}
      </button>
    )
  }
}
