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

    this.setState({
      isWaitingResult: true
    })

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
          isWaitingResult: false,
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
      isWaitingResult
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
      <div style={{ maxWidth: 600 }}>
        <div>
          {this.renderInput('left_input', left_input, isWaitingResult)}
          {this.renderInput('right_input', right_input, isWaitingResult)}
          <div>
            {operations.map(operation =>
              this.renderButton(operation, isInputValid, isWaitingResult)
            )}
          </div>
        </div>

        <div style={{
          fontSize: '7em',
          fontWeight: 'bold',
          fontFamily: 'Arial, sans-serif',
          textAlign: 'center',
          color: '#00A2FF'
        }}>
          {simple_result}
        </div>

        <textarea
          rows='4'
          disabled='true'
          value={detailed_result}
          style={{
            border: 0,
            width: '100%',
            resize: 'none',
            textAlign: 'center',
            overflow: 'hidden'
          }}
        />
      </div>
    )
  }

  renderInput (name, value, isWaitingResult) {
    return (
      <input
        type='number'
        name={name}
        value={value}
        disabled={isWaitingResult}
        onChange={this.onChangeInput}
        style={{
          border: 0,
          margin: 10,
          padding: 0,
          borderRadius: 10,
          display: 'inline-block',
          width: 'calc(50% - 20px)',
          height: '20vh',
          minHeight: 100,
          fontSize: '5em',
          fontFamily: 'Arial, sans-serif',
          textAlign: 'center',
          backgroundColor: '#F3F3F3'
        }}
      />
    )
  }

  renderButton (operation, isInputValid, isWaitingResult) {
    return (
      <button
        key={operation.name}
        name='operation'
        value={operation.name}
        disabled={isWaitingResult || !isInputValid}
        onClick={this.onSubmit}
        style={{
          border: 0,
          margin: 10,
          padding: 0,
          borderRadius: 10,
          display: 'inline-block',
          width: 'calc(25% - 20px)',
          height: '10vh',
          minHeight: 50,
          fontSize: '2em',
          textAlign: 'center',
          color: 'white',
          backgroundColor: '#00A2FF'
        }}
      >
        {operation.symbol}
      </button>
    )
  }
}
