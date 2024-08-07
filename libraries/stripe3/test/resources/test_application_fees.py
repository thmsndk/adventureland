import libraries.stripe3
from libraries.stripe3.test.helper import StripeResourceTest


class ApplicationFeeTest(StripeResourceTest):

    def test_list_application_fees(self):
        libraries.stripe3.ApplicationFee.list()
        self.requestor_mock.request.assert_called_with(
            'get',
            '/v1/application_fees',
            {}
        )


class ApplicationFeeRefundTest(StripeResourceTest):

    def test_fetch_refund(self):
        fee = libraries.stripe3.ApplicationFee.construct_from({
            'id': 'fee_get_refund',
            'refunds': {
                'object': 'list',
                'url': '/v1/application_fees/fee_get_refund/refunds',
            }
        }, 'api_key')

        fee.refunds.retrieve("ref_get")

        self.requestor_mock.request.assert_called_with(
            'get',
            '/v1/application_fees/fee_get_refund/refunds/ref_get',
            {},
            None
        )

    def test_list_refunds(self):
        fee = libraries.stripe3.ApplicationFee.construct_from({
            'id': 'fee_get_refund',
            'refunds': {
                'object': 'list',
                'url': '/v1/application_fees/fee_get_refund/refunds',
            }
        }, 'api_key')

        fee.refunds.list()

        self.requestor_mock.request.assert_called_with(
            'get',
            '/v1/application_fees/fee_get_refund/refunds',
            {},
            None
        )

    def test_update_refund(self):
        def side_effect(*args):
            raise libraries.stripe3.InvalidRequestError('invalid', 'foo')

        self.requestor_mock.request.side_effect = side_effect

        refund = libraries.stripe3.resource.ApplicationFeeRefund.construct_from({
            'id': "ref_update",
            'fee': "fee_update",
            'metadata': {},
        }, 'api_key')

        refund.metadata["key"] = "foo"

        try:
            refund.save()
        except libraries.stripe3.InvalidRequestError:
            pass

        self.requestor_mock.request.assert_called_with(
            'post',
            '/v1/application_fees/fee_update/refunds/ref_update',
            {
                'metadata': {
                    'key': 'foo',
                }
            },
            None
        )

        self.requestor_mock.request.side_effect = None

        refund.metadata["key"] = "bar"
        refund.save()

        self.requestor_mock.request.assert_called_with(
            'post',
            '/v1/application_fees/fee_update/refunds/ref_update',
            {
                'metadata': {
                    'key': 'bar',
                }
            },
            None
        )

    def test_modify_refund(self):
        libraries.stripe3.resource.ApplicationFeeRefund.modify("fee_update", "ref_update",
                                                    metadata={'key': 'foo'},
                                                    api_key='api_key')
        self.requestor_mock.request.assert_called_with(
            'post',
            '/v1/application_fees/fee_update/refunds/ref_update',
            {
                'metadata': {
                    'key': 'foo',
                }
            },
            None
        )
